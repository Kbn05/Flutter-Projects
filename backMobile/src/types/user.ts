import { Document, Schema, model } from 'mongoose';
import bcrypt from "bcryptjs";


export interface UserI extends Document{
    password: string;
    username: string;
    comparePassword: (password: string) => Promise<Boolean>
}

const userSchema = new Schema({
    username: {
      type: String,
      unique: true,
      required: true,
      lowercase: true,
      trim: true
    },
    password: {
      type: String,
      required: true
    }
  });

  userSchema.pre<UserI>("save", async function(next) {
    const UserI = this;
  
    if (!UserI.isModified("password")) return next();
  
    const salt = await bcrypt.genSalt(10);
    const hash = await bcrypt.hash(UserI.password, salt);
    UserI.password = hash;
  
    next();
  });
  
  userSchema.methods.comparePassword = async function(
    password: string
  ): Promise<Boolean> {
    return await bcrypt.compare(password, this.password);
  };
  
  export default model<UserI>("User", userSchema);