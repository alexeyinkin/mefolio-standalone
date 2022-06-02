## Install Tools ##

### Firebase ###

```bash
npm install -g firebase
npm install -g node-firestore-import-export
```

### Google Cloud ###

See https://cloud.google.com/sdk/docs/install

```bash
sudo apt-get install curl apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-cli
```

## Files that are not under version control ##

### .firebaserc ###

```json
{
  "projects": {
    "default": "your-firebase-project"
  }
}
```



## Import JSON ##

```bash
firestore-import --accountCredentials credentials.json --backupFile Project.json --nodePath Project
```

where `credentials.json` is a file you export from Firebase console as per this tutorial: https://www.youtube.com/watch?v=gPzs6t3tQak

