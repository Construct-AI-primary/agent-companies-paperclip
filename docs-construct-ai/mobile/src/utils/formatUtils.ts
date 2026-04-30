/**
 * Format a number as currency
 * @param amount - The amount to format
 * @returns Formatted currency string
 */
export const formatCurrency = (amount: number): string => {
  return new Intl.NumberFormat('en-ZA', {
    style: 'currency',
    currency: 'ZAR',
  }).format(amount);
};

/**
 * Format a date string
 * @param date - The date string to format
 * @returns Formatted date string
 */
export const formatDate = (date: string): string => {
  return new Date(date).toLocaleDateString('en-ZA', {
    day: '2-digit',
    month: 'short',
    year: 'numeric',
  });
};

/**
 * Format a date and time string
 * @param date - The date string to format
 * @returns Formatted date and time string
 */
export const formatDateTime = (date: string): string => {
  return new Date(date).toLocaleDateString('en-ZA', {
    day: '2-digit',
    month: 'short',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  });
};

/**
 * Truncate a string to a specified length
 * @param str - The string to truncate
 * @param length - The maximum length of the string
 * @returns Truncated string with ellipsis if needed
 */
export const truncateString = (str: string, length: number): string => {
  if (str.length <= length) {
    return str;
  }
  return str.substring(0, length) + '...';
};
