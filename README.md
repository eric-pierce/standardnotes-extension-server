### Standardnotes Extensions Server

- Auto-updating extensions server for your self-hosted Standard Notes server
- Currently 33 pre-configured open source extension repositories
- pure go, no git subprocess

### Usage

- Open Extensions Tab
- Use activation code `https://extensions.your.domain/index.json`

### Docker Compose Example (Dockerhub Image)

```yaml
  snext:
    container_name: snext
    image: ericpierce/standardnotes-extension-server
    restart: unless-stopped
    command: start-local
    networks:
      - traefik
    ports:
      - 8011:80
    volumes:
      - $DOCKERDIR/snext:/repos
    security_opt:
      - no-new-privileges:true
    environment:
      - TZ=$TZ
      - PUID=$PUID
      - PGID=$PGID
      - SN_EXTS_LISTEN_ADDR=:80
      - SN_EXTS_REPOS_DIR=/repos
      - SN_EXTS_DEFINITIONS_DIR=/definitions
      - SN_EXTS_BASE_URL=https://snext.$DOMAINNAME
      - SN_EXTS_UPDATE_INTERVAL_MINS=4320 # 3 days
```

### screenshots

![](https://i.imgur.com/EWQvpVR.png)
![](https://i.imgur.com/ZqmkzEW.png)
