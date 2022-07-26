import { S3Client } from "@aws-sdk/client-s3";
import multer from "multer";
import multerS3 from "multer-s3";
import { v4 } from "uuid";

const client = new S3Client({
  region: process.env.S3_REGION,
  credentials: {
    accessKeyId: process.env.S3_ACCESS_KEY,
    secretAccessKey: process.env.S3_ACCESS_SECRET,
  },
});

const ALLOWED_TYPES = ["image/jpeg", "image/png"];

const fileFilter = (
  req: Express.Request,
  file: Express.Multer.File,
  cb: Function
) => {
  if (ALLOWED_TYPES.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error("Invalid file type, only JPEG and PNG is allowed!"), false);
  }
};

const upload = (key = v4(), metadata?: Object) =>
  multer({
    fileFilter,
    storage: multerS3({
      s3: client,
      bucket: process.env.S3_BUCKET_NAME,
      metadata: function (req, file, cb) {
        cb(null, { ...metadata, fieldName: file.fieldname });
      },
      key: function (req, file, cb) {
        cb(null, `${key}-${file.originalname}`);
      },
    }),
  });

export { upload };
