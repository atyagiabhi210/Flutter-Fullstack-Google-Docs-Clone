const jwt = require("jsonwebtoken");
const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res
        .status(401)
        .json({ error: "No auth token found access denied" });
    }
    const verified = jwt.verify(token, "passwordKey");

    if (!verified) {
      return res
        .status(401)
        .json({ error: "Token verification failed access denied" });
    }

    req.user = verified.id;
    req.token = token;
    console.log("req.user", req.user);
    next();
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

module.exports = auth;
