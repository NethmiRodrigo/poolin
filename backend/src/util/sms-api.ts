const axios = require('axios');

/**
 * Sends the message passed to the given mobile number
 * @param message - content of the SMS 
 * @param to - recepient's mobile number
 * @returns - API response if successful, else logs error
 */
export const sendSMS = async(to: string, message: string) => {
  const config = {
    method: 'get',
    url: `http://send.ozonedesk.com/api/v2/send.php?user_id=104539&api_key=ioe5sr75ukghbqw0t&sender_id=ozoneDEMO&to=${to}&message=${message}`,
    headers: { }
  };

  try {
    const result = await axios(config)
    return JSON.stringify(result)
  } catch (error) {
    console.log(error);
  }
}