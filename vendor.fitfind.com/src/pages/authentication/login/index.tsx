import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { useRouter } from "next/router";
import { toast } from "react-toastify";
import Cookies from "js-cookie";
import {
  Col,
  Container,
  Row,
  FormGroup,
  Input,
  Label,
  Button,
} from "reactstrap";
import Link from "next/link";
import { useState } from "react";
import { Facebook, Linkedin, Twitter } from "react-feather";
import CommonLogo from "./CommonLogo";

// ✅ Zod Schema for Validation
const loginSchema = z.object({
  email: z.string().email("Invalid email format"),
  password: z.string().min(6, "Password must be at least 6 characters"),
});

type LoginFormInputs = z.infer<typeof loginSchema>;

const Login = () => {
  const [showPassWord, setShowPassWord] = useState(false);
  const router = useRouter();

  const {
    register,
    handleSubmit,
    reset,
    formState: { errors },
  } = useForm<LoginFormInputs>({
    resolver: zodResolver(loginSchema),
  });

  const onSubmit = (data: LoginFormInputs) => {
    console.log("Form Submitted:", data);

    if (data.email === "Test@gmail.com" && data.password === "Test@123") {
      Cookies.set("token", JSON.stringify(true));
      router.push("/sample-page");
      toast.success("Login successful");
    } else {
      toast.error("Invalid email or password");
    }

    reset();
  };

  return (
    <Container fluid className="p-0">
      <Row className="m-0">
        <Col xs={12} className="p-0">
          <div className="login-card login-dark">
            <div>
              <CommonLogo />
              <div className="login-main">
                <form className="theme-form" onSubmit={handleSubmit(onSubmit)}>
                  <h4>Sign In to Your Account</h4>
                  <p>Enter your email and password to login.</p>

                  <FormGroup>
                    <Label className="col-form-label">Email Address</Label>
                    <Input
                      type="email"
                      placeholder="Test@gmail.com"
                      {...register("email")}
                    />
                    {errors.email && (
                      <p className="text-danger">{errors.email.message}</p>
                    )}
                  </FormGroup>

                  <FormGroup>
                    <Label className="col-form-label">Password</Label>
                    <div className="form-input position-relative">
                      <Input
                        type={showPassWord ? "text" : "password"}
                        placeholder="*********"
                        {...register("password")}
                      />
                      <div className="show-hide">
                        <span
                          onClick={() => setShowPassWord(!showPassWord)}
                          className={!showPassWord ? "show" : ""}
                        />
                      </div>
                    </div>
                    {errors.password && (
                      <p className="text-danger">{errors.password.message}</p>
                    )}
                  </FormGroup>

                  <FormGroup className="mb-0 form-group">
                    <div className="checkbox p-0">
                      <Input id="checkbox1" type="checkbox" />
                      <Label className="text-muted" htmlFor="checkbox1">
                        Remember Password
                      </Label>
                    </div>
                    <Link
                      className="link"
                      href="/pages/authentication/forget-pwd"
                    >
                      Forgot Password?
                    </Link>
                    <div className="text-end mt-3">
                      <Button
                        color="primary"
                        className="btn-block w-100"
                        type="submit"
                      >
                        Sign In
                      </Button>
                    </div>
                  </FormGroup>

                  <p className="mt-4 mb-0 text-center">
                    Don’t have an account?
                    <Link
                      className="ms-2"
                      href="/pages/authentication/register-simple"
                    >
                      Create Account
                    </Link>
                  </p>
                </form>
              </div>
            </div>
          </div>
        </Col>
      </Row>
    </Container>
  );
};

export default Login;
