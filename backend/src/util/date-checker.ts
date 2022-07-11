/**
 * Checks if a date has expired
 * @param date
 * @returns boolean
 */
export const checkIfDateIsExpired = (date: Date) => {
  const today = new Date();
  if (today > date) return false;
  return true;
};
