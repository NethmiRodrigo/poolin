import nodemailer, { TestAccount, Transporter } from "nodemailer";
import SMTPConnection from "nodemailer/lib/smtp-connection";
import SMTPTransport from "nodemailer/lib/smtp-transport";
import { MailOptions } from "nodemailer/lib/json-transport";
import dotenv from "dotenv";

dotenv.config();

const config: SMTPTransport.Options = {
  host: process.env.EMAIL_HOST,
  port: parseInt(<string>process.env.EMAIL_PORT),
  secure: false,
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
};

/**
 * Creates a test email account
 * @returns TestAccount
 */
const createTestMail = async () => {
  return await nodemailer.createTestAccount();
};

/**
 * Creates a mail transporter
 * @returns Transporter
 */
const createMailer = async () => {
  if (process.env.NODE_ENV !== "production") {
    let emailAccount: TestAccount = await createTestMail();
    const auth: SMTPConnection.Credentials = {
      user: emailAccount.user,
      pass: emailAccount.pass,
    };
    config.auth = auth;
  }
  return nodemailer.createTransport(config);
};

/**
 * Calls mail creator function and returns it
 * @returns Transporter
 */
export const getMailer = async () => {
  const mailer: Transporter = await createMailer();
  return mailer;
};

/**
 * Function to send a plain email with no embedded html
 * @param from -  The sender of the email
 * @param to - The email of the recipient
 * @param subject - The email subject
 * @param body - The text to be sent in the email body
 */
export const sendPlainMail = async (mailOptions: MailOptions): Promise<any> => {
  const mailer = await getMailer();
  let result: any;
  return new Promise((resolve, reject) => {
    mailer.sendMail(mailOptions, (err: Error, info: any) => {
      if (err) reject(err);
      else {
        result = info;
        resolve(result);
      }
    });
  });
};
