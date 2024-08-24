//document
// user id
// created at
// title (default untitled)
//  content
const mongoose = require("mongoose");

const documentSchema = new mongoose.Schema({
  uid: {
    type: String,
    required: true,
  },
  createdAt: {
    required: true,
    type: Number,
  },
  title: {
    type: String,
    required: true,
    trim: true,
  },
  content: {
    type: Array,
    default: [],
  },
});

const Document= mongoose.model("Doucument", documentSchema);

module.exports = Document;
