---
name: performance-testing-qualityforge
description: Performance testing including Lighthouse scores, bundle analysis, and load times
company: qualityforge-ai
category: testing
priority: P3
---

# Performance Testing

## Purpose
Test application performance, load times, bundle sizes, and overall user experience responsiveness.

## Test Procedures

### 1. Lighthouse Audits
- [ ] Run Lighthouse on all key pages (home, dashboard, discipline pages, settings)
- [ ] Verify Performance score >= 90
- [ ] Verify Accessibility score >= 90
- [ ] Verify Best Practices score >= 90
- [ ] Verify SEO score >= 90
- [ ] Document and address all failing audits
- [ ] Test on mobile and desktop configurations

### 2. Bundle Analysis
- [ ] Run bundle analyzer on production build
- [ ] Verify total JS bundle size < 500KB (gzipped)
- [ ] Identify and document largest dependencies
- [ ] Check for duplicate packages
- [ ] Verify code splitting is effective
- [ ] Verify tree shaking is removing unused code
- [ ] Check for oversized assets (images, fonts)

### 3. Load Time Testing
- [ ] Measure Time to First Byte (TTFB) < 200ms
- [ ] Measure First Contentful Paint (FCP) < 1.5s
- [ ] Measure Largest Contentful Paint (LCP) < 2.5s
- [ ] Measure Time to Interactive (TTI) < 3.5s
- [ ] Measure Cumulative Layout Shift (CLS) < 0.1
- [ ] Test on 3G, 4G, and broadband connections
- [ ] Test cold load vs cached load

### 4. API Performance
- [ ] Measure API response times < 500ms (p95)
- [ ] Test concurrent request handling
- [ ] Verify pagination performance on large datasets
- [ ] Test database query performance
- [ ] Verify caching effectiveness (cache hit rates)

### 5. Memory and CPU Profiling
- [ ] Test for memory leaks during extended use
- [ ] Verify garbage collection frequency
- [ ] Profile CPU-intensive operations
- [ ] Test scroll performance (60fps target)
- [ ] Verify animation smoothness

### 6. Network Optimization
- [ ] Verify HTTP/2 or HTTP/3 usage
- [ ] Check compression (gzip/brotli) enabled
- [ ] Verify CDN caching headers correct
- [ ] Test image optimization (WebP, lazy loading)
- [ ] Verify font loading strategy (swap, preload)

## Expected Outcomes
- Lighthouse scores >= 90 on all categories
- JS bundle < 500KB gzipped
- LCP < 2.5s on all key pages
- No memory leaks during extended sessions
- API responses < 500ms (p95)