import Link from "next/link";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { Button, Col, FormGroup, Input, Label, Row } from "reactstrap";
import { useEffect, useState } from "react";
import CommonLogo from "./CommonLogo";

const registerSchema = z.object({
  firstName: z.string().min(2, "First name must be at least 2 characters"),
  lastName: z.string().min(2, "Last name must be at least 2 characters"),
  email: z.string().email("Invalid email format"),
  password: z.string().min(6, "Password must be at least 6 characters"),
  agree: z.boolean().refine((val) => val === true, {
    message: "You must agree to the privacy policy",
  }),
});

type RegisterFormInputs = z.infer<typeof registerSchema>;

const CommonRegisterForm = () => {
  const [showPassword, setShowPassword] = useState(false);
  const [regData, setRegData] = useState<RegisterFormInputs | null>(null);

  const {
    register,
    handleSubmit,
    reset,
    formState: { errors },
  } = useForm<RegisterFormInputs>({
    resolver: zodResolver(registerSchema),
  });

  const onSubmit = (data: RegisterFormInputs) => {
    const { firstName, lastName, ...rest } = data;
    const fullName = `${firstName} ${lastName}`.trim();
    const updatedData = { ...rest, fullName };

    console.log("🚀 Updated Data:", updatedData);
  };

  return (
    <div className="login-card login-dark">
      <div>
        <div>
          <CommonLogo />
        </div>
        <div className="login-main">
          <form className="theme-form" onSubmit={handleSubmit(onSubmit)}>
            <h4>Create Your Account</h4>
            <p>Enter your personal details to create an account.</p>

            <FormGroup>
              <Label className="col-form-label pt-0">Your Name</Label>
              <Row className="g-2">
                <Col xs={6}>
                  <Input
                    type="text"
                    placeholder="First name"
                    {...register("firstName")}
                  />
                  {errors.firstName && (
                    <p className="text-danger">{errors.firstName.message}</p>
                  )}
                </Col>
                <Col xs={6}>
                  <Input
                    type="text"
                    placeholder="Last name"
                    {...register("lastName")}
                  />
                  {errors.lastName && (
                    <p className="text-danger">{errors.lastName.message}</p>
                  )}
                </Col>
              </Row>
            </FormGroup>

            <FormGroup>
              <Label className="col-form-label">Email Address</Label>
              <Input
                type="email"
                placeholder="example@gmail.com"
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
                  type={showPassword ? "text" : "password"}
                  placeholder="*********"
                  {...register("password")}
                />
                <div className="show-hide">
                  <span
                    onClick={() => setShowPassword(!showPassword)}
                    className={!showPassword ? "show" : ""}
                  />
                </div>
              </div>
              {errors.password && (
                <p className="text-danger">{errors.password.message}</p>
              )}
            </FormGroup>

            <FormGroup className="mb-0">
              <div className="checkbox p-0">
                <Input id="checkbox1" type="checkbox" {...register("agree")} />
                <Label className="text-muted" htmlFor="checkbox1">
                  Agree with{" "}
                  <a className="ms-2" href="#">
                    Privacy Policy
                  </a>
                </Label>
              </div>
              {errors.agree && (
                <p className="text-danger">{errors.agree.message}</p>
              )}

              <Button type="submit" color="primary" className="btn-block w-100">
                Create Account
              </Button>
            </FormGroup>

            <p className="mt-4 mb-0">
              Already have an account?
              <Link className="ms-2" href="/pages/authentication/login-simple">
                Sign In
              </Link>
            </p>
          </form>
        </div>
      </div>
    </div>
  );
};

export default CommonRegisterForm;
