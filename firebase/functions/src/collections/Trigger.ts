import * as functions from "firebase-functions";

import {update as updateProjectFilterStats} from "./ProjectFilterStat";

export const Trigger_updateProjectFilterStats = functions.firestore.document("/Trigger/updateProjectFilterStats").onUpdate(async (change, context) => {
    await updateProjectFilterStats();
});
