# mefolio-standalone

An engine to maintain a personal portfolio website and mobile apps.
An example website that uses it: https://alexeyinkin.com (my own portfolio).

## Setting up Your Portfolio

A portfolio comprises:
- A Flutter app that compiles to web app, Android and iOS apps.
- A Firestore database with Firebase Cloud Functions to index and serve data.

These are built from this repository.

The Flutter app is not shipped pre-built because the build should contain your credentials
to access your Firestore database. So you build your app using this source.
To avoid merging on updates, you are encouraged to not fork it but to build and deploy it as is.

The Firestore app contains security rules and cloud functions to index your portfolio data
for complex queries. You deploy it into your Firebase project as is.

You may add your portfolio data directly in Firestore console. However, it is more convenient
to have your data in version-controlled files that get imported to Firestore on your command.
My portfolio uses this approach, and my data can be found here:
https://github.com/alexeyinkin/mefolio-alexeyinkin.com
You are welcome to use this structure to fill it with your data.

### Directory Structure ###

The following structure is suggested on your development machine:

```
mefolio                       A working directory for your project
├── mefolio-standalone        A checkout of mefolio-standalone
└── mefolio-my                A checkout of repository with your portfolio data
```

### Setting up a Firebase Project ###

These instructions are for Ubuntu.

1. Go to Firebase console: https://console.firebase.google.com.
2. Create a new empty project.
3. Install `nodejs` to your local machine: https://nodejs.org/en/download/package-manager/

As root:
```bash
apt install curl -y
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
apt-get install -y nodejs
```

4. Set up Firebase CLI and link the checked-out directory to your project.

Full instructions on Firebase CLI: https://firebase.google.com/docs/cli

As root:
```bash
npm install -g firebase-tools
```

As a normal user:
```bash
firebase login
cd mefolio/mefolio-standalone/firebase
firebase init
```

Mark Firestore and Functions, use existing project, select the project, use the default file names,
select TypeScript, enable ESLint. Many of the default Firebase files already exist in the project.
When asked to keep or overwrite them, opt to keep them (the default).

5. Deploy the functions and security rules. You will be required to switch to Blaze plan.
This plan is required to run cloud functions. See below if you cannot switch to Blaze.

```bash
firebase deploy
```

6. Get a credentials file to allow command-line data import. In Firebase Console,
click the gear next to Project Overview. On Service accounts tab, click "Generate new privat key"
button. Rename the downloaded file to `credentials.json` and put in to the root of your
`mefolio-my`. This is optional, but this location will be used in command examples below. 
Be sure to add it to `.gitignore` so that you do not accidentally publish it.

7. Set up a firebase import tool:

As root:
```bash
npm install -g node-firestore-import-export
```

8. Import your data.

```bash
cd mefolio/mefolio-my
firestore-import --accountCredentials credentials.json --backupFile Global.json --nodePath Global
firestore-import --accountCredentials credentials.json --backupFile Role.json --nodePath Role
firestore-import --accountCredentials credentials.json --backupFile Project.json --nodePath Project
firestore-import --accountCredentials credentials.json --backupFile Trigger.json --nodePath Trigger
```

9. Generate heavy data.

Most of the supplementary data is generated by triggers when importing the above files.
However, some operations are heavy and are only triggered manually to allow you to double check
your import first and to save time and resources.

For this, there is a collection named `Trigger`. Each document in it is named after
some long-running operation. To fire it, change any field in the corresponding document.
The documents themselves are not used in any other way so they may contain any data.
Just create, update or delete any fields in them to fire an operation.

Only one such operation exists at the moment, `updateProjectFilterStats`. It generates
project tag combination statistics. Add any field to it, e.g. `a: 1`.

### Setting up a Flutter Project ###

```bash
dart pub global activate flutterfire_cli
cd mefolio/mefolio-standalone/flutter
~/.pub-cache/bin/flutterfire configure
```

Select the project, select platforms (only Web at the moment).

This will generate `lib/firebase_options.dart`, the only file missing in the repository
to successfully build your web application.

For iOS and Android, you need to update your application IDs.

TODO: Make a script that does it, so that version-controlled configuration files
do not hardcode application IDs.

## Running Firebase without Blaze Plan ##

There are reasons to not switch to Blaze plan:
- Higher payment requirements.
- Hitting a personal quota on paid projects: https://support.google.com/cloud/answer/6330231

You can run this project without cloud functions. The functions are only used to initially
index the data but not to serve it. So you have two options:

1. Run a Firebase emulator locally, import your data locally, and allow cloud functions
to do their work locally. Then export the data and import them to your real Firestore project.
2. Use another Blaze project to let the functions do their work, then dump the data and import
them to your real Firestore project.

Help is wanted to add instructions on these here.