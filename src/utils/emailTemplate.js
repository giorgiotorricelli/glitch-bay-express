export function getCyberpunkEmailBody({ firstName, lastName, address, phone, tracking_number, invoice_id, products, productDetailsMap, shipping_cost, payment_methods, total_amount }) {

    const productsListHtml = products.map(product => {
        const details = productDetailsMap.get(product.id) || { name: `Prodotto #${product.id}`, price: product.paid };
        const haSconto = details.price > product.paid;

        const prezzoMostrato = haSconto
            ? `<span style="color: #ff0055; text-decoration: line-through; font-size: 12px; margin-right: 5px;">€${parseFloat(details.price).toFixed(2)}</span> <span style="color: #00f0ff; font-weight: bold;">€${product.paid.toFixed(2)}</span>`
            : `<span style="color: #ffffff; font-weight: bold;">€${product.paid.toFixed(2)}</span>`;

        return `
        <tr style="border-bottom: 1px solid #222233;">
            <td style="padding: 12px 0; color: #ffffff; font-size: 14px;">
                <strong style="display: block; color: #ffffff; font-size: 15px;">${details.name}</strong>
                <span style="color: #888899; font-size: 12px;">Quantità: ${product.qty} &times; Prezzo Unitario: ${prezzoMostrato}</span>
            </td>
            <td align="right" style="padding: 12px 0; color: #00f0ff; font-family: monospace; font-size: 15px; font-weight: bold; vertical-align: middle;">
                €${(product.paid * product.qty).toFixed(2)}
            </td>
        </tr>
        <tr>
            <td colspan="2" style="height: 1px; background-color: #222233; padding: 0;"></td>
        </tr>
        `;
    }).join('');

    return `
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8">
        <title>Conferma Ordine Glitch Bay</title>
    </head>
    <body style="margin: 0; padding: 0; background-color: #000000; font-family: 'Montserrat', sans-serif; color: #ffffff;">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color: #000000; padding: 20px 10px;">
            <tr>
                <td align="center">
                    <table border="0" cellpadding="0" cellspacing="0" width="600" style="background-color: #0d0d13; border: 2px solid #00f0ff; padding: 30px; border-radius: 4px;">
                        <tr>
                            <td align="center" style="padding-bottom: 30px; border-bottom: 1px dashed #00f0ff;">
                                <h1 style="font-family: 'Courier New', monospace; color: #00f0ff; font-size: 26px; text-transform: uppercase; margin: 0; letter-spacing: 2px;">
                                    GLITCH BAY 
                                </h1>
                                <p style="color: #888899; font-size: 12px; margin: 5px 0 0 0; text-transform: uppercase; letter-spacing: 1px;">
                                    Recupera il passato, arreda il tuo futuro.
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 30px 0 10px 0;">
                                <h2 style="color: #ffffff; font-size: 20px; margin: 0 0 10px 0; font-weight: 500;">
                                    Grazie per il tuo acquisto, <span style="color: #00f0ff;">${firstName}</span>!
                                </h2>
                                <p style="color: #b0b0bc; font-size: 14px; line-height: 1.6; margin: 0;">
                                    Il tuo ordine è stato creato con successo. Di seguito trovi il riepilogo completo.
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 20px 0;">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color: #11111a; border-left: 4px solid #00f0ff; padding: 15px;">
                                    <tr>
                                        <td style="color: #ffffff; font-size: 14px; line-height: 1.5;">
                                            <strong style="color: #00f0ff; text-transform: uppercase; font-size: 12px; display: block; margin-bottom: 5px; letter-spacing: 1px;">[ DATI DI SPEDIZIONE ]</strong>
                                            <b style="color: #fff;">Destinatario:</b> ${firstName} ${lastName}<br />
                                            <b style="color: #fff;">Indirizzo:</b> ${address}<br />
                                            <b style="color: #fff;">Telefono:</b> ${phone}<br />
                                            <b style="color: #fff;">Tracking Node:</b> <span style="font-family: monospace; background: #222; padding: 2px 6px; color: #ff0055; border-radius: 3px;">${tracking_number}</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 10px 0 20px 0;">
                                <h3 style="color: #00f0ff; font-size: 14px; text-transform: uppercase; margin: 0 0 15px 0; letter-spacing: 1px;">
                                [ LISTA PRODOTTI ACQUISTATI ]
                                </h3>
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    ${productsListHtml}
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 10px;">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td style="color: #888899; font-size: 14px; padding: 4px 0;">Spese di Spedizione:</td>
                                        <td align="right" style="color: #ffffff; font-size: 14px; padding: 4px 0; font-family: monospace;">
                                            ${shipping_cost === 0 ? '<span style="color: #00f0ff; text-transform:uppercase; font-size:12px;">FREE_SHIPPING</span>' : `€${shipping_cost.toFixed(2)}`}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="color: #888899; font-size: 14px; padding: 4px 0;">Metodo Pagamento:</td>
                                        <td align="right" style="color: #ffffff; font-size: 13px; padding: 4px 0; text-transform: uppercase; font-family: monospace;">
                                            ${payment_methods}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="padding: 15px 0 5px 0;"><div style="height: 1px; background-color: #00f0ff;"></div></td>
                                    </tr>
                                    <tr>
                                        <td style="color: #ffffff; font-size: 18px; font-weight: bold; padding: 10px 0; text-transform: uppercase; letter-spacing: 1px;">
                                            TOTALE CORE:
                                        </td>
                                        <td align="right" style="color: #00f0ff; font-size: 22px; font-weight: bold; padding: 10px 0; font-family: monospace;">
                                            €${(total_amount + shipping_cost).toFixed(2)}
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" style="padding-top: 30px; border-top: 1px dashed #222233; color: #555566; font-size: 11px; font-family: monospace;">
                                TRANSAZIONE PROTOCOLLATA DA GLITCH BAY SYSTEM // ID_INVOICE: ${invoice_id}<br>
                                Se non hai effettuato tu questo ordine, contatta immediatamente il terminale di supporto.
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
    </html>
    `;
}