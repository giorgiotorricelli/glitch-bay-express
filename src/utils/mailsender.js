import nodemailer from 'nodemailer'

const host = process.env.SMTP_HOST;
const port = process.env.SMTP_PORT;
const user = process.env.SMTP_USERNAME;
const pass = process.env.SMTP_PASSWORD;




const transporter = nodemailer.createTransport({
    host: host,
    port : port,
    secure: false,
    auth: {
        user: user,
        pass: pass
    }
});

export function mailSender (to, subject, body, textBody){
    return transporter.sendMail({
        from: `"Glitch Bay Support" <${user}>`,
        to,
        subject,
        text: textBody || "Grazie per il tuo ordine! Trovi i dettagli nella versione HTML di questa e-mail.",
        html: body
    });
}