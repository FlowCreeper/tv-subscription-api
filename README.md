# TV Subscription API

## Setup

- Ruby: 3.4.4
- Rails: 8.0.2
- Postgres: 16

### Local Setup

```bash
git clone https://github.com/FlowCreeper/tv-subscription-api
cd tv_subscription_api

cp .env.sample .env
bundle install
```

### Set up the database
```bash
rails db:create db:migrate db:seed
```

### Start the server
```bash
rails server
```

## API Endpoints

All routes are under the `/api` namespace and follow standard REST conventions for CRUD operations.

---

### Customers

| Method | Endpoint                 | Description            |
|--------|--------------------------|------------------------|
| GET    | `/api/customers`         | List all customers     |
| POST   | `/api/customers`         | Create a new customer  |
| GET    | `/api/customers/:id`     | Get one customer       |
| PUT    | `/api/customers/:id`     | Update customer        |
| DELETE | `/api/customers/:id`     | Delete customer        |

---

### Plans

| Method | Endpoint             | Description       |
|--------|----------------------|-------------------|
| GET    | `/api/plans`         | List all plans    |
| POST   | `/api/plans`         | Create a plan     |
| GET    | `/api/plans/:id`     | Get one plan      |
| PUT    | `/api/plans/:id`     | Update a plan     |
| DELETE | `/api/plans/:id`     | Delete a plan     |

---

### Adicional Services

| Method | Endpoint                        | Description              |
|--------|----------------------------------|--------------------------|
| GET    | `/api/adicional_services`       | List all services        |
| POST   | `/api/adicional_services`       | Create a service         |
| GET    | `/api/adicional_services/:id`   | Get one service          |
| PUT    | `/api/adicional_services/:id`   | Update a service         |
| DELETE | `/api/adicional_services/:id`   | Delete a service         |

---

### Packages

| Method | Endpoint            | Description         |
|--------|---------------------|---------------------|
| GET    | `/api/packages`     | List all packages   |
| POST   | `/api/packages`     | Create a package    |
| GET    | `/api/packages/:id` | Get one package     |
| PUT    | `/api/packages/:id` | Update a package    |
| DELETE | `/api/packages/:id` | Delete a package    |

---

### Subscriptions

| Method | Endpoint                   | Description             |
|--------|----------------------------|-------------------------|
| GET    | `/api/subscriptions`       | List all subscriptions |
| POST   | `/api/subscriptions`       | Create a subscription  |
| GET    | `/api/subscriptions/:id`   | Get one subscription   |
| PUT    | `/api/subscriptions/:id`   | Update a subscription  |
| DELETE | `/api/subscriptions/:id`   | Delete a subscription  |

---

### Invoices (PDF)

| Method | Endpoint                 | Description                                                   |
|--------|--------------------------|---------------------------------------------------------------|
| GET    | `/api/invoices/:id`      | Get a PDF invoice by ID or customer name                     |

---

### Booklets (12-month PDF)

| Method | Endpoint                | Description                                                    |
|--------|-------------------------|----------------------------------------------------------------|
| GET    | `/api/booklets/:id`     | Get a 12-month booklet PDF by subscription ID or customer name |