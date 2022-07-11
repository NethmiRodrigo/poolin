/**
 * Util function to generate an OTP
 * @param length - The required length of the OTP. Default is 5
 * @returns A strig of the required length
 */
export default (length: number = 5, isIntOnly: boolean = false) => {
  const possible: string = isIntOnly
    ? "1234567890"
    : "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@$#&^%*!";
  let text: string = "";
  for (let i = 0; i < length; i++) {
    text += possible.charAt(Math.floor(Math.random() * possible.length));
  }
  return text;
};
