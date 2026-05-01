"use strict";
/**
 * LingoGou — Cloud Functions
 *
 * verifyPurchase: recibe el purchaseToken de Google Play desde el cliente Flutter,
 * lo valida con la Google Play Developer API y actualiza el campo `isPremium`
 * en el documento Firestore del usuario usando Admin SDK (bypassea las reglas).
 *
 * Requisito previo (configuración manual única):
 *   1. En Google Cloud Console → IAM → Cuentas de servicio, la cuenta por defecto
 *      de App Engine (<project-id>@appspot.gserviceaccount.com) debe existir.
 *   2. En Google Play Console → Configuración → Acceso a la API, vincular ese
 *      proyecto de Google Cloud y conceder a esa cuenta de servicio el rol
 *      "Visualizador de pedidos y suscripciones".
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.verifyPurchase = void 0;
const https_1 = require("firebase-functions/v2/https");
const firebase_functions_1 = require("firebase-functions");
const admin = require("firebase-admin");
const googleapis_1 = require("googleapis");
admin.initializeApp();
exports.verifyPurchase = (0, https_1.onCall)({ region: "us-central1" }, async (request) => {
    // ── 1. Autenticación ───────────────────────────────────────────────────
    if (!request.auth) {
        throw new https_1.HttpsError("unauthenticated", "La función requiere que el usuario esté autenticado.");
    }
    const uid = request.auth.uid;
    const data = request.data;
    const { purchaseToken, productId, packageName } = data;
    if (!purchaseToken || !productId || !packageName) {
        throw new https_1.HttpsError("invalid-argument", "Faltan parámetros requeridos: purchaseToken, productId, packageName.");
    }
    firebase_functions_1.logger.info("verifyPurchase iniciado", { uid, productId });
    try {
        // ── 2. Autenticar con Google Play Developer API ────────────────────
        // Usa Application Default Credentials (la cuenta de servicio del proyecto).
        const auth = new googleapis_1.google.auth.GoogleAuth({
            scopes: ["https://www.googleapis.com/auth/androidpublisher"],
        });
        const androidpublisher = googleapis_1.google.androidpublisher({
            version: "v3",
            auth,
        });
        // ── 3. Verificar con Google Play ───────────────────────────────────
        // Intentamos primero como suscripción (el caso esperado para premium_monthly).
        // Si falla, lo intentamos como compra única.
        let isPremium = false;
        try {
            const subResponse = await androidpublisher.purchases.subscriptions.get({
                packageName,
                subscriptionId: productId,
                token: purchaseToken,
            });
            const sub = subResponse.data;
            const expiryMs = parseInt(sub.expiryTimeMillis ?? "0", 10);
            const isExpired = expiryMs < Date.now();
            // cancelReason definido → el usuario canceló (pero puede seguir activo hasta expiryTime)
            const isCanceledAndExpired = sub.cancelReason !== undefined && isExpired;
            isPremium = !isExpired && !isCanceledAndExpired;
            firebase_functions_1.logger.info("Verificación de suscripción", {
                uid,
                expiryMs,
                cancelReason: sub.cancelReason,
                isPremium,
            });
        }
        catch (subError) {
            // Puede ser producto de pago único — intentar con purchases.products
            firebase_functions_1.logger.warn("No es suscripción, intentando como producto único", {
                uid,
                productId,
            });
            const productResponse = await androidpublisher.purchases.products.get({
                packageName,
                productId,
                token: purchaseToken,
            });
            // purchaseState: 0 = comprado, 1 = cancelado, 2 = pendiente
            isPremium = productResponse.data.purchaseState === 0;
            firebase_functions_1.logger.info("Verificación de producto único", { uid, isPremium });
        }
        // ── 4. Actualizar Firestore con Admin SDK ──────────────────────────
        // Admin SDK bypasea las reglas de seguridad de Firestore.
        // El cliente NUNCA puede escribir isPremium directamente.
        await admin.firestore().collection("users").doc(uid).set({ isPremium }, { merge: true });
        firebase_functions_1.logger.info("Firestore actualizado", { uid, isPremium });
        return {
            isPremium,
            message: isPremium
                ? "Suscripción activa. ¡Bienvenido a LingoGou Premium!"
                : "Suscripción inactiva o expirada.",
        };
    }
    catch (error) {
        firebase_functions_1.logger.error("Error en verifyPurchase", { uid, error });
        // No exponer detalles internos al cliente
        throw new https_1.HttpsError("internal", "Error al verificar la compra con Google Play. Intenta de nuevo.");
    }
});
//# sourceMappingURL=index.js.map