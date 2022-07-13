const axios = require('axios');

/**
 * Sends the message passed to the given mobile number
 * @param message - content of the SMS 
 * @param to - recepient's mobile number
 * @returns - boolean
 */
export const sendSMS = async(to: string, message: string) => {
  const config = {
    method: 'get',
    url: `http://send.ozonedesk.com/api/v2/send.php?user_id=104540&api_key=4z5nkaiqjxmn7yk5z&sender_id=ozoneDEMO&to=${to}&message=${message}`,
    headers: { }
  };

  let result;

  try {
    const response = await axios(config)
    result = response;
  } catch (error) {
    result = error;
    console.log(error);
  }

  if (result.data.msg) return false;
  return true;
}