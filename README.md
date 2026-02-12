# Elasticsearch Railway Template

Deploy Elasticsearch on Railway with a single click.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/elasticsearch-engine)

## Features

- Elasticsearch single-node deployment
- X-Pack security enabled with configurable credentials
- Persistent data storage via Railway volume
- Anonymous read access for monitoring

## Configuration

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `PORT` | `9200` | HTTP port |
| `ES_JAVA_OPTS` | `-Xms500m -Xmx4g` | JVM heap settings |
| `ELASTIC_PASSWORD` | (required) | Password for the `elastic` user |
| `ELASTIC_USERNAME` | `elastic` | Username for authentication |

### Volume

Mount a volume at `/esdata` for persistent index storage.

### Healthcheck

Use `/_cluster/health` endpoint to verify the service is running:

```bash
curl -u elastic:$ELASTIC_PASSWORD http://localhost:9200/_cluster/health
```

## Railway Deployment

1. Click the Deploy button above or create a new project from this repo
2. Add a volume mounted at `/esdata`
3. Set `ELASTIC_PASSWORD` to a secure value
4. Deploy

## Connection

From other Railway services in the same project, connect via private networking:

```
http://elasticsearch.railway.internal:9200
```

Authentication:
```
Username: elastic
Password: <your ELASTIC_PASSWORD>
```
