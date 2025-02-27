import CommonLogo from "@/components/Others/authentication/common/CommonLogo";
import Link from "next/link";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import {
  Button,
  Col,
  Container,
  FormGroup,
  Input,
  Label,
  Row,
} from "reactstrap";
import {
  CreateYourPassword,
  Done,
  EnterOTP,
  Href,
  NewPassword,
  RememberPassword,
  Resend,
  RetypePassword,
  Signin,
  havePassword,
  EnterYourEmailAddress,
  IfDontReciveOtp,
  ImgPath,
  ResetYourPassword,
  Send,
} from "utils/Constant";

const schema = z
  .object({
    email: z.string().email("Invalid email format"),
    otp: z.string().min(6, "OTP must be 6 digits"),
    newPassword: z.string().min(8, "Password must be at least 8 characters"),
    confirmPassword: z.string(),
  })
  .refine((data) => data.newPassword === data.confirmPassword, {
    message: "Passwords do not match",
    path: ["confirmPassword"],
  });

const ForgetPassWord = () => {
  const [showPassWord, setShowPassWord] = useState(false);
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm({
    resolver: zodResolver(schema),
  });

  const onSubmit = (data: any) => {
    console.log(data);
  };

  return (
    <div className="page-wrapper">
      <Container fluid className="p-0">
        <Row>
          <Col xs={12}>
            <div className="login-card login-dark">
              <div>
                <div>
                  <CommonLogo />
                </div>
                <div className="login-main">
                  <form
                    className="theme-form"
                    onSubmit={handleSubmit(onSubmit)}
                  >
                    <h4>{ResetYourPassword}</h4>
                    <FormGroup>
                      <Label className="col-form-label">
                        {EnterYourEmailAddress}
                      </Label>
                      <Input
                        className="mb-1"
                        type="email"
                        placeholder={EnterYourEmailAddress}
                        {...register("email")}
                      />
                      {errors.email && (
                        <p className="text-danger">{errors.email.message}</p>
                      )}
                    </FormGroup>
                    <Col xs={12}>
                      <div className="text-end">
                        <Button
                          color="primary"
                          className="btn-block m-t-10"
                          type="submit"
                        >
                          {Send}
                        </Button>
                      </div>
                    </Col>
                    <div className="mt-4 mb-4">
                      <span className="reset-password-link">
                        {IfDontReciveOtp}
                        <a className="btn-link txt-danger ms-2" href={Href}>
                          {Resend}
                        </a>
                      </span>
                    </div>
                    <FormGroup>
                      <Label className="col-form-label pt-0">{EnterOTP}</Label>
                      <Input
                        className="text-center opt-text"
                        type="text"
                        maxLength={6}
                        placeholder="Enter OTP"
                        {...register("otp")}
                      />
                      {errors.otp && (
                        <p className="text-danger">{errors.otp.message}</p>
                      )}
                    </FormGroup>
                    <h6 className="mt-4">{CreateYourPassword}</h6>
                    <FormGroup>
                      <Label className="col-form-label">{NewPassword}</Label>
                      <div className="form-input position-relative">
                        <Input
                          type={showPassWord ? "text" : "password"}
                          placeholder="*********"
                          {...register("newPassword")}
                        />
                        <div className="show-hide">
                          <span
                            onClick={() => setShowPassWord(!showPassWord)}
                            className={!showPassWord ? "show" : ""}
                          />
                        </div>
                      </div>
                      {errors.newPassword && (
                        <p className="text-danger">
                          {errors.newPassword.message}
                        </p>
                      )}
                    </FormGroup>
                    <FormGroup>
                      <Label className="col-form-label">{RetypePassword}</Label>
                      <Input
                        type={showPassWord ? "text" : "password"}
                        placeholder="*********"
                        {...register("confirmPassword")}
                      />
                      {errors.confirmPassword && (
                        <p className="text-danger">
                          {errors.confirmPassword.message}
                        </p>
                      )}
                    </FormGroup>
                    <FormGroup className="mb-0">
                      <div className="checkbox p-0">
                        <Input id="checkbox1" type="checkbox" />
                        <Label className="text-muted" htmlFor="checkbox1">
                          {RememberPassword}
                        </Label>
                      </div>
                      <Button
                        color="primary"
                        className="btn-block w-100"
                        type="submit"
                      >
                        {Done}
                      </Button>
                    </FormGroup>
                    <p className="mt-4 mb-0 text-center">
                      {havePassword}
                      <Link
                        className="ms-2"
                        href="/pages/authentication/sign-up-two"
                      >
                        {Signin}
                      </Link>
                    </p>
                  </form>
                </div>
              </div>
            </div>
          </Col>
        </Row>
      </Container>
    </div>
  );
};

export default ForgetPassWord;
