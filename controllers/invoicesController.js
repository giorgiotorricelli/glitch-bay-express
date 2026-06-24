import { db } from '../config/db.js';
import { formatInvoices, generateTrackingNumber, getTop5Products } from '../src/utils/function.js';
import { insertInvoice, queryInvoiceIndex, queryInvoiceShow, insertUser, insertOrder, queryProductsByIds } from '../src/utils/query.js';
import { mailSender } from '../src/utils/mailsender.js';
import { getCyberpunkEmailBody } from '../src/utils/emailTemplate.js';


/*
INDEX
*/
export async function index(request, response) {
    try {
        const [result] = await db.query(queryInvoiceIndex);
        const invoice = formatInvoices(result);
        
        response
            .json({
                error: null,
                result: invoice
            });

    } catch (error) {
        console.error(error);
        response
            .status(500)
            .json({
                error: "Errore nell'esecuzione della richiesta",
                result: null
            });
    }
}



/*
SHOW
*/
export async function show(request, response) {
    try {
        const id = request.params.id;
        const [result] = await db.execute(queryInvoiceShow, [id]);
        if (result.length === 0) {
            response
                .json({
                    error: 'La fattura cercata non esiste',
                    result: null
                })
        }
        const invoice = formatInvoices(result);
        response
            .json({
                error: null,
                result: invoice[0]
            })
    } catch (error) {
        console.error(error);
        response
            .status(500)
            .json({
                error: "Errore nell'esecuzione della richiesta",
                result: null
            });
    }
};


/*
CREATE
*/

export async function store(request, response) {
    try {
        const { payment_methods, firstName, lastName, mail, address, phone, products } = request.body;
        let total_amount = 0;

        for (const product of products) {
            total_amount += product.paid * product.qty;
        }
        const shipping_cost = total_amount < 250 ? 9.99 : 0;
        const tracking_number = generateTrackingNumber();

        await db.beginTransaction();
        const [resultInvoice] = await db.execute(insertInvoice, [total_amount, 'paid', shipping_cost, tracking_number, payment_methods]);
        console.log(resultInvoice)
        const invoice_id = resultInvoice.insertId;
        const [resultUser] = await db.execute(insertUser, [invoice_id, firstName, lastName, mail, address, phone]);
        console.log(resultUser)
        for (const product of products) {
            const { id, paid, qty } = product;
            const [resultOrder] = await db.execute(insertOrder, [id, invoice_id, paid, qty]);
            console.log(resultOrder)
        }
        await db.commit();

        try {
            const productIds = products.map(p => p.id);
            const [dbProducts] = await db.query(queryProductsByIds, [productIds]);
            const productDetailsMap = new Map(dbProducts.map(p => [p.id, p]));

            const emailBody = getCyberpunkEmailBody({
                firstName, lastName, address, phone, tracking_number, invoice_id,
                products, productDetailsMap, shipping_cost, payment_methods, total_amount
            });

            const emailSubject = `⚡ [GLITCH BAY] CONFERMA ORDINE #${invoice_id}`;
            

            await mailSender(mail, emailSubject, emailBody);
            console.log(`Email di conferma inviata con successo a: ${mail}`);

        } catch (emailError) {
            console.error("Mailing system log:", emailError);
        }

        response
            .status(201)
            .json({
                error: null,
                result: `L'ordine é stato creato con successo`,
                data: {
                    invoiceNum: invoice_id,
                    tracking_number:tracking_number
                }
            });

    } catch (error) {
        if (db) await db.rollback();
        console.error(`errore durante la transizione:`,error);
        response
            .status(500)
            .json({
                error: "Errore nell'esecuzione della richiesta",
                result: null
            });
    }
}


