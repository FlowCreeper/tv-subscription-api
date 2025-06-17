# TV Subscription API

## 🛠️ Setup

- Ruby: 3.4.4
- Rails: 8.0.2
- Postgres: 16

### 🔧 Local Setup

```bash
git clone ...
cd tv_subscription_api
cp .env.sample .env
bundle install
```

### Routes
- api/
  - invoices/
    - GET show/:id
      - id can be the name of customer or invoice id
      - returns a invoice pdf
  - booklets/
    - GET show/:id
      - id can be the name of customer or subscription id
      - returns a booklet pdf