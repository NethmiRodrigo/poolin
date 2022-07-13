import { Router } from "express";

/** Middleware */
import auth from "../../middleware/auth";

/** Routes */
import { getLoggedInUser, login, logout } from "./login";
import {
  resetPassword,
  sendResetPasswordEmail,
  verifyResetPasswordOTP,
} from "./reset-password";
import {
  resendEmailOTP,
  verifyCredentials,
  verifyEmailOTP,
  verifyMobileNumber,
  verifySMSOTP,
  verifyUserInfo,
} from "./register";

const router = Router();
router.post("/login", login);
router.post("/me", auth, getLoggedInUser);
router.post("/logout", auth, logout);

/** Reset password routes */
router.post("/send-reset-password-email", sendResetPasswordEmail);
router.post("/verify-password-otp", verifyResetPasswordOTP);
router.post("/reset-password", resetPassword);

/** Registration routes */
router.post("/verify-credentials", verifyCredentials);
router.post("/verify-mobile-num", verifyMobileNumber);
router.post("/verify-email-otp", verifyEmailOTP);
router.post("/verify-sms-otp", verifySMSOTP);
router.post("/resend-email-otp", resendEmailOTP);
router.post("/verify-user-info", verifyUserInfo);

export default router;
