---
title: Buyer Agent Page Knowledge
description: Comprehensive page-specific knowledge for procurement UI components, tables, workflows, and system interactions used by the Buyer agent
author: KnowledgeForge AI
version: 1.0
memory_layer: durable_knowledge
para_section: docs_paperclip/companies/knowledgeforge-ai/agents/Buyer
gigabrain_tags: knowledgeforge-ai, buyer-agent, procurement-ui, procurement-workflows, supplier-management, purchase-orders
openstinger_context: buyer-agent-ui, procurement-page-interactions
last_updated: 2026-04-10
related_docs:
  - docs-paperclip/disciplines/01900-procurement/knowledge/PAGE-KNOWLEDGE.md
  - docs-construct-ai/disciplines/01900_procurement/agent-data/domain-knowledge/1900_DOMAIN-KNOWLEDGE.MD
  - docs-paperclip/companies/knowledgeforge-ai/skills/buyer-knowledgeforge/SKILL.md
---

# Buyer Agent Page Knowledge

## Overview

This document provides the Buyer agent with comprehensive knowledge of procurement system UI components, table structures, workflow interactions, and page-specific functionality. The Buyer agent requires detailed understanding of supplier management, purchase order processing, vendor negotiations, and procurement analytics to effectively manage procurement operations.

**Purpose**: Enable the Buyer agent to navigate procurement interfaces, interpret data tables, execute procurement workflows, and provide accurate procurement guidance within the Construct AI ecosystem.

---

## Part 1: Procurement Dashboard UI Components

### 1.1 Main Procurement Dashboard Layout

**URL Pattern**: `/procurement/dashboard`
**Primary Components**:
- **Header Navigation**: Procurement menu with quick access to key functions
- **Metrics Cards**: KPI widgets showing procurement performance
- **Recent Activity Feed**: Timeline of procurement actions and approvals
- **Quick Actions Panel**: Shortcuts for common procurement tasks

#### Header Navigation Structure
```jsx
<ProcurementHeader>
  <NavMenu>
    <NavItem href="/procurement/dashboard">Dashboard</NavItem>
    <NavItem href="/procurement/suppliers">Suppliers</NavItem>
    <NavItem href="/procurement/purchase-orders">Purchase Orders</NavItem>
    <NavItem href="/procurement/requisitions">Requisitions</NavItem>
    <NavItem href="/procurement/contracts">Contracts</NavItem>
    <NavItem href="/procurement/analytics">Analytics</NavItem>
  </NavMenu>
  <UserMenu>
    <QuickActions>
      <ActionButton>New Purchase Order</ActionButton>
      <ActionButton>Add Supplier</ActionButton>
      <ActionButton>View Approvals</ActionButton>
    </QuickActions>
  </UserMenu>
</ProcurementHeader>
```

#### Metrics Cards Configuration
```jsx
<MetricsGrid>
  <MetricCard title="Active POs" value="47" trend="+12%" color="blue">
    <Icon name="shopping-cart" />
  </MetricCard>
  <MetricCard title="Pending Approvals" value="8" trend="-3" color="orange">
    <Icon name="clock" />
  </MetricCard>
  <MetricCard title="Supplier Performance" value="94%" trend="+2%" color="green">
    <Icon name="star" />
  </MetricCard>
  <MetricCard title="Monthly Spend" value="$2.4M" trend="+8%" color="purple">
    <Icon name="dollar-sign" />
  </MetricCard>
</MetricsGrid>
```

### 1.2 Dashboard State Management

**Redux Store Structure**:
```javascript
const procurementDashboard = {
  metrics: {
    activePOs: 47,
    pendingApprovals: 8,
    supplierPerformance: 94,
    monthlySpend: 2400000
  },
  recentActivity: [
    { id: 1, type: 'po_approved', description: 'PO-2026-001 approved', timestamp: '2026-04-10T10:30:00Z' },
    { id: 2, type: 'supplier_added', description: 'New supplier ABC Corp added', timestamp: '2026-04-10T09:15:00Z' }
  ],
  quickActions: {
    newPO: { enabled: true, permissions: ['buyer', 'procurement_manager'] },
    addSupplier: { enabled: true, permissions: ['buyer', 'supplier_admin'] },
    viewApprovals: { enabled: true, permissions: ['buyer'] }
  }
}
```

---

## Part 2: Supplier Management Tables and Interfaces

### 2.1 Supplier Directory Table

**URL**: `/procurement/suppliers`
**Table Configuration**:

```jsx
<SupplierTable
  columns={[
    { key: 'supplierCode', label: 'Supplier Code', sortable: true, filterable: true },
    { key: 'supplierName', label: 'Supplier Name', sortable: true, filterable: true },
    { key: 'category', label: 'Category', filterable: true },
    { key: 'status', label: 'Status', filterable: true, badge: true },
    { key: 'performanceScore', label: 'Performance', sortable: true, format: 'percentage' },
    { key: 'lastOrderDate', label: 'Last Order', sortable: true, format: 'date' },
    { key: 'totalSpend', label: 'Total Spend', sortable: true, format: 'currency' },
    { key: 'actions', label: 'Actions', type: 'actions' }
  ]}
  data={supplierData}
  pagination={{ pageSize: 25, showSizeChanger: true }}
  rowSelection={{ type: 'checkbox', onChange: handleSelection }}
/>
```

#### Table Data Structure
```javascript
const supplierColumns = [
  {
    title: 'Supplier Code',
    dataIndex: 'supplierCode',
    key: 'supplierCode',
    sorter: true,
    filters: [],
    filterSearch: true,
    width: 120
  },
  {
    title: 'Supplier Name',
    dataIndex: 'supplierName',
    key: 'supplierName',
    sorter: true,
    filters: [],
    filterSearch: true,
    width: 200
  },
  {
    title: 'Category',
    dataIndex: 'category',
    key: 'category',
    filters: [
      { text: 'Materials', value: 'materials' },
      { text: 'Services', value: 'services' },
      { text: 'Equipment', value: 'equipment' }
    ],
    width: 120
  },
  {
    title: 'Status',
    dataIndex: 'status',
    key: 'status',
    filters: [
      { text: 'Active', value: 'active' },
      { text: 'Inactive', value: 'inactive' },
      { text: 'Under Review', value: 'under_review' }
    ],
    render: (status) => (
      <Badge status={getStatusColor(status)} text={status} />
    ),
    width: 100
  },
  {
    title: 'Performance Score',
    dataIndex: 'performanceScore',
    key: 'performanceScore',
    sorter: true,
    render: (score) => `${score}%`,
    width: 120
  },
  {
    title: 'Last Order',
    dataIndex: 'lastOrderDate',
    key: 'lastOrderDate',
    sorter: true,
    render: (date) => formatDate(date),
    width: 120
  },
  {
    title: 'Total Spend',
    dataIndex: 'totalSpend',
    key: 'totalSpend',
    sorter: true,
    render: (amount) => formatCurrency(amount),
    width: 120
  },
  {
    title: 'Actions',
    key: 'actions',
    render: (_, record) => (
      <Space size="middle">
        <Button type="link" onClick={() => viewSupplier(record.id)}>
          View
        </Button>
        <Button type="link" onClick={() => editSupplier(record.id)}>
          Edit
        </Button>
        <Dropdown menu={{ items: getActionMenu(record) }}>
          <Button type="link">More</Button>
        </Dropdown>
      </Space>
    ),
    width: 120
  }
];
```

### 2.2 Supplier Detail Modal

**Trigger**: Click "View" or "Edit" on supplier table row
**Modal Structure**:

```jsx
<SupplierDetailModal
  visible={modalVisible}
  supplier={selectedSupplier}
  mode={modalMode} // 'view' | 'edit'
  onSave={handleSaveSupplier}
  onCancel={handleCancelModal}
>
  <Tabs defaultActiveKey="general">
    <TabPane tab="General Information" key="general">
      <Form layout="vertical">
        <Form.Item label="Supplier Code" name="supplierCode">
          <Input disabled={mode === 'view'} />
        </Form.Item>
        <Form.Item label="Supplier Name" name="supplierName">
          <Input disabled={mode === 'view'} />
        </Form.Item>
        <Form.Item label="Category" name="category">
          <Select disabled={mode === 'view'}>
            <Option value="materials">Materials</Option>
            <Option value="services">Services</Option>
            <Option value="equipment">Equipment</Option>
          </Select>
        </Form.Item>
        <Form.Item label="Status" name="status">
          <Select disabled={mode === 'view'}>
            <Option value="active">Active</Option>
            <Option value="inactive">Inactive</Option>
            <Option value="under_review">Under Review</Option>
          </Select>
        </Form.Item>
      </Form>
    </TabPane>

    <TabPane tab="Contact Information" key="contact">
      <Form layout="vertical">
        <Form.Item label="Primary Contact" name="primaryContact">
          <Input disabled={mode === 'view'} />
        </Form.Item>
        <Form.Item label="Email" name="email">
          <Input type="email" disabled={mode === 'view'} />
        </Form.Item>
        <Form.Item label="Phone" name="phone">
          <Input disabled={mode === 'view'} />
        </Form.Item>
        <Form.Item label="Address" name="address">
          <TextArea rows={3} disabled={mode === 'view'} />
        </Form.Item>
      </Form>
    </TabPane>

    <TabPane tab="Performance Metrics" key="performance">
      <PerformanceCharts supplierId={supplier.id} />
    </TabPane>

    <TabPane tab="Purchase History" key="history">
      <PurchaseHistoryTable supplierId={supplier.id} />
    </TabPane>
  </Tabs>
</SupplierDetailModal>
```

---

## Part 3: Purchase Order Workflows

### 3.1 Purchase Order Creation Workflow

**URL**: `/procurement/purchase-orders/new`
**Workflow Steps**:

1. **Requisition Selection**
   - Select from approved requisitions
   - Review item specifications and quantities
   - Check budget availability

2. **Supplier Selection**
   - Search approved suppliers by category
   - Review supplier performance metrics
   - Compare pricing and terms

3. **PO Details Entry**
   - Auto-populate from requisition
   - Add supplier-specific terms
   - Calculate totals and taxes

4. **Approval Routing**
   - Automatic routing based on amount
   - Sequential approval workflow
   - Email notifications to approvers

#### Workflow State Management
```javascript
const poWorkflowStates = {
  draft: {
    label: 'Draft',
    color: 'gray',
    actions: ['edit', 'submit'],
    nextStates: ['submitted']
  },
  submitted: {
    label: 'Submitted',
    color: 'blue',
    actions: ['withdraw'],
    nextStates: ['approved', 'rejected', 'needs_revision']
  },
  approved: {
    label: 'Approved',
    color: 'green',
    actions: ['send_to_supplier'],
    nextStates: ['sent_to_supplier']
  },
  sent_to_supplier: {
    label: 'Sent to Supplier',
    color: 'purple',
    actions: ['mark_received'],
    nextStates: ['goods_received', 'cancelled']
  },
  goods_received: {
    label: 'Goods Received',
    color: 'green',
    actions: ['close_po'],
    nextStates: ['closed']
  },
  closed: {
    label: 'Closed',
    color: 'gray',
    actions: [],
    nextStates: []
  }
};
```

### 3.2 Purchase Order Form Structure

```jsx
<PurchaseOrderForm>
  <Card title="Purchase Order Header">
    <Row gutter={16}>
      <Col span={8}>
        <Form.Item label="PO Number" name="poNumber">
          <Input disabled />
        </Form.Item>
      </Col>
      <Col span={8}>
        <Form.Item label="Supplier" name="supplierId" rules={[{ required: true }]}>
          <Select showSearch optionFilterProp="children">
            {supplierOptions.map(supplier => (
              <Option key={supplier.id} value={supplier.id}>
                {supplier.name}
              </Option>
            ))}
          </Select>
        </Form.Item>
      </Col>
      <Col span={8}>
        <Form.Item label="Currency" name="currency">
          <Select>
            <Option value="USD">USD</Option>
            <Option value="EUR">EUR</Option>
            <Option value="GBP">GBP</Option>
          </Select>
        </Form.Item>
      </Col>
    </Row>
  </Card>

  <Card title="Line Items">
    <Form.List name="lineItems">
      {(fields, { add, remove }) => (
        <>
          {fields.map(({ key, name, ...restField }) => (
            <Row key={key} gutter={16} align="middle">
              <Col span={6}>
                <Form.Item {...restField} name={[name, 'itemCode']} rules={[{ required: true }]}>
                  <Input placeholder="Item Code" />
                </Form.Item>
              </Col>
              <Col span={8}>
                <Form.Item {...restField} name={[name, 'description']} rules={[{ required: true }]}>
                  <Input placeholder="Description" />
                </Form.Item>
              </Col>
              <Col span={3}>
                <Form.Item {...restField} name={[name, 'quantity']} rules={[{ required: true }]}>
                  <InputNumber min={1} placeholder="Qty" />
                </Form.Item>
              </Col>
              <Col span={3}>
                <Form.Item {...restField} name={[name, 'unitPrice']} rules={[{ required: true }]}>
                  <InputNumber min={0} step={0.01} placeholder="Price" />
                </Form.Item>
              </Col>
              <Col span={3}>
                <Form.Item {...restField} name={[name, 'total']}>
                  <InputNumber disabled />
                </Form.Item>
              </Col>
              <Col span={1}>
                <Button type="link" danger onClick={() => remove(name)}>
                  <DeleteOutlined />
                </Button>
              </Col>
            </Row>
          ))}
          <Form.Item>
            <Button type="dashed" onClick={() => add()} block icon={<PlusOutlined />}>
              Add Item
            </Button>
          </Form.Item>
        </>
      )}
    </Form.List>
  </Card>

  <Card title="Terms and Conditions">
    <Form.Item label="Payment Terms" name="paymentTerms">
      <Select>
        <Option value="net30">Net 30</Option>
        <Option value="net60">Net 60</Option>
        <Option value="cod">Cash on Delivery</Option>
      </Select>
    </Form.Item>
    <Form.Item label="Delivery Terms" name="deliveryTerms">
      <TextArea rows={3} placeholder="FOB, CIF, etc." />
    </Form.Item>
    <Form.Item label="Special Instructions" name="specialInstructions">
      <TextArea rows={3} />
    </Form.Item>
  </Card>
</PurchaseOrderForm>
```

---

## Part 4: Approval Workflow Interfaces

### 4.1 Approval Queue Table

**URL**: `/procurement/approvals`
**Table Structure**:

```jsx
<ApprovalQueueTable
  columns={[
    { key: 'documentType', label: 'Type', filterable: true },
    { key: 'documentNumber', label: 'Document #', sortable: true },
    { key: 'description', label: 'Description' },
    { key: 'amount', label: 'Amount', sortable: true, format: 'currency' },
    { key: 'submittedBy', label: 'Submitted By', filterable: true },
    { key: 'submittedDate', label: 'Submitted', sortable: true, format: 'date' },
    { key: 'urgency', label: 'Urgency', filterable: true, badge: true },
    { key: 'actions', label: 'Actions', type: 'actions' }
  ]}
  data={approvalData}
  expandable={{
    expandedRowRender: (record) => <ApprovalDetail record={record} />
  }}
/>
```

### 4.2 Approval Action Modal

```jsx
<ApprovalModal
  visible={approvalModalVisible}
  document={selectedDocument}
  onApprove={handleApprove}
  onReject={handleReject}
  onRequestRevision={handleRequestRevision}
>
  <div className="approval-header">
    <h3>{document.type}: {document.number}</h3>
    <Badge status={getUrgencyColor(document.urgency)} text={document.urgency} />
  </div>

  <div className="document-summary">
    <Row gutter={16}>
      <Col span={12}>
        <Statistic title="Amount" value={document.amount} prefix="$" />
      </Col>
      <Col span={12}>
        <Statistic title="Submitted" value={formatDate(document.submittedDate)} />
      </Col>
    </Row>
  </div>

  <Tabs defaultActiveKey="details">
    <TabPane tab="Document Details" key="details">
      <DocumentPreview documentId={document.id} />
    </TabPane>
    <TabPane tab="Approval History" key="history">
      <ApprovalHistory documentId={document.id} />
    </TabPane>
    <TabPane tab="Comments" key="comments">
      <CommentsSection documentId={document.id} />
    </TabPane>
  </Tabs>

  <div className="approval-actions">
    <TextArea
      placeholder="Add approval comments..."
      value={approvalComments}
      onChange={(e) => setApprovalComments(e.target.value)}
    />
    <Space>
      <Button onClick={handleReject} danger>
        Reject
      </Button>
      <Button onClick={handleRequestRevision} type="default">
        Request Revision
      </Button>
      <Button onClick={handleApprove} type="primary">
        Approve
      </Button>
    </Space>
  </div>
</ApprovalModal>
```

---

## Part 5: Procurement Analytics and Reporting

### 5.1 Spend Analysis Dashboard

**URL**: `/procurement/analytics/spend`
**Chart Components**:

```jsx
<SpendAnalysisDashboard>
  <Row gutter={16}>
    <Col span={12}>
      <Card title="Spend by Category">
        <PieChart
          data={spendByCategory}
          config={{
            angleField: 'value',
            colorField: 'category',
            label: { type: 'inner', content: '{percentage}' }
          }}
        />
      </Card>
    </Col>
    <Col span={12}>
      <Card title="Monthly Spend Trend">
        <LineChart
          data={monthlySpendData}
          xField="month"
          yField="spend"
          seriesField="year"
        />
      </Card>
    </Col>
  </Row>

  <Row gutter={16}>
    <Col span={24}>
      <Card title="Top Suppliers by Spend">
        <Table
          columns={supplierSpendColumns}
          dataSource={topSuppliersBySpend}
          pagination={false}
          size="small"
        />
      </Card>
    </Col>
  </Row>
</SpendAnalysisDashboard>
```

### 5.2 Supplier Performance Dashboard

```jsx
<SupplierPerformanceDashboard>
  <Row gutter={16}>
    <Col span={6}>
      <StatisticCard
        title="On-Time Delivery"
        value={94.2}
        suffix="%"
        trend="+2.1%"
        color="green"
      />
    </Col>
    <Col span={6}>
      <StatisticCard
        title="Quality Score"
        value={87.5}
        suffix="%"
        trend="-0.5%"
        color="orange"
      />
    </Col>
    <Col span={6}>
      <StatisticCard
        title="Average Lead Time"
        value={12.3}
        suffix=" days"
        trend="-1.2 days"
        color="green"
      />
    </Col>
    <Col span={6}>
      <StatisticCard
        title="Cost Variance"
        value={3.2}
        suffix="%"
        trend="+0.8%"
        color="red"
      />
    </Col>
  </Row>

  <Card title="Supplier Performance Matrix">
    <ScatterPlot
      data={supplierPerformanceData}
      xField="qualityScore"
      yField="onTimeDelivery"
      colorField="supplierTier"
      sizeField="totalSpend"
      tooltip={{
        fields: ['supplierName', 'qualityScore', 'onTimeDelivery', 'totalSpend']
      }}
    />
  </Card>
</SupplierPerformanceDashboard>
```

---

## Part 6: Integration Points and API Interactions

### 6.1 Email Integration for PO Communications

```javascript
// Send PO to supplier
const sendPOToSupplier = async (poId, supplierEmail) => {
  const poData = await api.get(`/procurement/purchase-orders/${poId}`);
  const emailTemplate = generatePOEmailTemplate(poData);

  return await api.post('/email/send', {
    to: supplierEmail,
    subject: `Purchase Order ${poData.poNumber}`,
    template: 'purchase-order',
    data: {
      poNumber: poData.poNumber,
      supplierName: poData.supplier.name,
      lineItems: poData.lineItems,
      totalAmount: poData.totalAmount,
      deliveryDate: poData.deliveryDate,
      paymentTerms: poData.paymentTerms
    },
    attachments: [{
      filename: `PO-${poData.poNumber}.pdf`,
      content: generatePOPDF(poData)
    }]
  });
};
```

### 6.2 Inventory System Integration

```javascript
// Update inventory on goods receipt
const updateInventoryOnReceipt = async (poId, receiptData) => {
  const poData = await api.get(`/procurement/purchase-orders/${poId}`);

  // Update inventory levels
  for (const item of receiptData.items) {
    await api.post('/inventory/adjustments', {
      itemCode: item.itemCode,
      quantity: item.receivedQuantity,
      adjustmentType: 'purchase_receipt',
      reference: `PO-${poData.poNumber}`,
      location: receiptData.location
    });
  }

  // Update PO status
  await api.patch(`/procurement/purchase-orders/${poId}`, {
    status: 'goods_received',
    receivedDate: new Date().toISOString(),
    receiptData: receiptData
  });
};
```

### 6.3 Financial System Integration

```javascript
// Create accounting entries for PO
const createAccountingEntries = async (poId) => {
  const poData = await api.get(`/procurement/purchase-orders/${poId}`);

  const journalEntry = {
    date: poData.approvedDate,
    reference: `PO-${poData.poNumber}`,
    description: `Purchase Order - ${poData.supplier.name}`,
    lines: [
      {
        account: 'inventory',
        debit: poData.totalAmount,
        description: 'Inventory increase'
      },
      {
        account: 'accounts_payable',
        credit: poData.totalAmount,
        description: 'Accounts payable increase'
      }
    ]
  };

  return await api.post('/accounting/journal-entries', journalEntry);
};
```

---

## Part 7: Navigation and Routing Patterns

### 7.1 Procurement Module Navigation

```javascript
const procurementRoutes = [
  {
    path: '/procurement',
    component: ProcurementLayout,
    children: [
      { path: 'dashboard', component: ProcurementDashboard },
      { path: 'suppliers', component: SupplierManagement },
      { path: 'suppliers/:id', component: SupplierDetail },
      { path: 'purchase-orders', component: PurchaseOrderList },
      { path: 'purchase-orders/new', component: PurchaseOrderForm },
      { path: 'purchase-orders/:id', component: PurchaseOrderDetail },
      { path: 'requisitions', component: RequisitionList },
      { path: 'requisitions/:id', component: RequisitionDetail },
      { path: 'contracts', component: ContractManagement },
      { path: 'analytics', component: ProcurementAnalytics },
      { path: 'approvals', component: ApprovalQueue }
    ]
  }
];
```

### 7.2 Breadcrumb Navigation

```jsx
<BreadcrumbNavigation>
  <Breadcrumb.Item href="/procurement/dashboard">Procurement</Breadcrumb.Item>
  <Breadcrumb.Item href="/procurement/suppliers">Suppliers</Breadcrumb.Item>
  <Breadcrumb.Item>ABC Corporation</Breadcrumb.Item>
</BreadcrumbNavigation>
```

---

## Part 8: Form Validation and Error Handling

### 8.1 Purchase Order Form Validation

```javascript
const poFormValidationRules = {
  supplierId: [
    { required: true, message: 'Please select a supplier' }
  ],
  currency: [
    { required: true, message: 'Please select currency' }
  ],
  'lineItems[].itemCode': [
    { required: true, message: 'Item code is required' }
  ],
  'lineItems[].description': [
    { required: true, message: 'Description is required' },
    { min: 10, message: 'Description must be at least 10 characters' }
  ],
  'lineItems[].quantity': [
    { required: true, message: 'Quantity is required' },
    { type: 'number', min: 1, message: 'Quantity must be at least 1' }
  ],
  'lineItems[].unitPrice': [
    { required: true, message: 'Unit price is required' },
    { type: 'number', min: 0, message: 'Unit price cannot be negative' }
  ],
  paymentTerms: [
    { required: true, message: 'Payment terms are required' }
  ],
  deliveryDate: [
    { required: true, message: 'Delivery date is required' },
    { type: 'date', message: 'Please select a valid date' }
  ]
};
```

### 8.2 Error Handling Patterns

```javascript
const handleApiError = (error) => {
  switch (error.status) {
    case 400:
      notification.error({
        message: 'Validation Error',
        description: 'Please check your input and try again.'
      });
      break;
    case 403:
      notification.error({
        message: 'Permission Denied',
        description: 'You do not have permission to perform this action.'
      });
      break;
    case 409:
      notification.error({
        message: 'Conflict',
        description: 'This action conflicts with existing data.'
      });
      break;
    default:
      notification.error({
        message: 'System Error',
        description: 'An unexpected error occurred. Please try again.'
      });
  }
};
```

---

## Part 9: Accessibility and User Experience

### 9.1 Keyboard Navigation

- **Tab Order**: Logical tab sequence through form fields
- **Enter Key**: Submit forms and trigger primary actions
- **Escape Key**: Close modals and cancel operations
- **Arrow Keys**: Navigate table rows and dropdown options

### 9.2 Screen Reader Support

```jsx
// ARIA labels and descriptions
<Form.Item
  label="Supplier Selection"
  name="supplierId"
  rules={[{ required: true, message: 'Please select a supplier' }]}
>
  <Select
    showSearch
    optionFilterProp="children"
    aria-label="Select supplier from approved supplier list"
    aria-describedby="supplier-help"
  >
    {supplierOptions.map(supplier => (
      <Option
        key={supplier.id}
        value={supplier.id}
        aria-label={`Supplier: ${supplier.name}, Category: ${supplier.category}`}
      >
        {supplier.name}
      </Option>
    ))}
  </Select>
</Form.Item>
<p id="supplier-help" className="sr-only">
  Select a supplier from the approved supplier list. Use the search field to filter suppliers by name.
</p>
```

### 9.3 Loading States and Feedback

```jsx
const [loading, setLoading] = useState(false);
const [submitting, setSubmitting] = useState(false);

const handleSubmit = async (values) => {
  setSubmitting(true);
  try {
    await api.post('/procurement/purchase-orders', values);
    notification.success({
      message: 'Purchase Order Created',
      description: 'The purchase order has been successfully created and sent for approval.'
    });
    navigate('/procurement/purchase-orders');
  } catch (error) {
    handleApiError(error);
  } finally {
    setSubmitting(false);
  }
};
```

---

## Conclusion

This page knowledge document provides the Buyer agent with comprehensive understanding of procurement system interfaces, workflows, and interactions. The agent can now effectively navigate procurement dashboards, manage supplier relationships, process purchase orders, handle approvals, analyze procurement data, and integrate with related systems.

**Key Capabilities Enabled**:
- ✅ Navigate complex procurement interfaces
- ✅ Interpret and manipulate procurement data tables
- ✅ Execute multi-step procurement workflows
- ✅ Handle supplier and purchase order management
- ✅ Process approval queues and routing
- ✅ Generate procurement analytics and reports
- ✅ Integrate with email, inventory, and financial systems
- ✅ Maintain accessibility and user experience standards

**Continuous Learning**: This knowledge base should be updated as new procurement features are added and UI patterns evolve.

---

**Document Version:** 1.0
**Effective Date:** 2026-04-10
**Owner:** KnowledgeForge AI - Buyer Agent
**Last Reviewed:** 2026-04-10