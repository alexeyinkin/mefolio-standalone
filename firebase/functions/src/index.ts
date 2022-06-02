import * as admin from "firebase-admin";

export * from "./collections/Project";
export * from "./collections/Tag";
export * from "./collections/Trigger";

admin.initializeApp();
