# Docker Stack - Minecraft Server & Monitoring

## Services

- **Minecraft Bedrock Server** (Port 19132-19133)
- **Elasticsearch** (Port 9200)
- **Kibana** (Port 5601)
- **Filebeat** (Log Collection)
- **Metricbeat** (System Metrics)
- **Paperless** (DMS)

## URLs

- **Kibana Dashboard:** http://100.83.215.34:5601/app/home#/
- **Elasticsearch:** http://100.83.215.34:9200
- **Minecraft Server:** `192.168.178.140:19132` (lokal) / `212.51.156.152:19132` (extern)
- **Paperless** http://100.83.215.34:8010/d

## Docker Commands

### Starten
```bash
cd /home/tom/docker
docker compose up -d
```

### Stoppen
```bash
docker compose down
```

### Logs anzeigen
```bash
# Alle Services
docker compose logs -f

# Einzelner Service
docker compose logs -f minecraft
docker compose logs -f elasticsearch
docker compose logs -f kibana
docker compose logs -f filebeat
docker compose logs -f metricbeat
```

### Status prüfen
```bash
docker compose ps
```

### Einzelne Services neu starten
```bash
docker compose restart minecraft
docker compose restart elasticsearch
```

### Services einzeln starten/stoppen
```bash
docker compose up -d minecraft
docker compose stop kibana
```

### Updates
```bash
# Images aktualisieren
docker compose pull

# Mit neuen Images neu starten
docker compose up -d
```

## Backup

### Minecraft World Backup
```bash
tar -czf backup-$(date +%Y%m%d).tar.gz minecraft/data/worlds/
```

### Komplettes Backup
```bash
tar -czf docker-backup-$(date +%Y%m%d).tar.gz \
  --exclude='elasticsearch/data' \
  --exclude='minecraft/data/worlds' \
  .
```

## Troubleshooting

### Ports prüfen
```bash
sudo ss -tulnp | grep -E '19132|9200|5601'
```

### Container-Ressourcen
```bash
docker stats
```

### Logs durchsuchen
```bash
docker compose logs minecraft | grep -i error
```

### Alles neu starten
```bash
docker compose down
docker compose up -d
```
