import { formatCurrency, formatDate } from '../formatUtils';

describe('formatUtils', () => {
  describe('formatCurrency', () => {
    it('should format a number as currency', () => {
      // Note: The actual format may vary based on the system locale
      expect(formatCurrency(1000)).toMatch(/R\s*1\s*000,00/);
      expect(formatCurrency(1000.5)).toMatch(/R\s*1\s*000,50/);
      expect(formatCurrency(0)).toMatch(/R\s*0,00/);
    });
  });

  describe('formatDate', () => {
    it('should format a date string', () => {
      const date = '2023-01-01';
      expect(formatDate(date)).toBe('01 Jan 2023');
    });
  });
});
