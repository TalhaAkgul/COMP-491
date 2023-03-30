/*!

=========================================================
* Paper Kit React - v1.3.1
=========================================================

* Product Page: https://www.creative-tim.com/product/paper-kit-react

* Copyright 2022 Creative Tim (https://www.creative-tim.com)
* Licensed under MIT (https://github.com/creativetimofficial/paper-kit-react/blob/main/LICENSE.md)

* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

*/
import React from "react";

// reactstrap components
import {
  Button,
  Card,
  CardBody,
  CardFooter,
  CardTitle,
  Form,
  Input,
  InputGroupAddon,
  InputGroupText,
  InputGroup,
  Container,
  Row,
  Col
} from "reactstrap";

// core components
import ExamplesNavbar from "components/Navbars/MyNavbar.js";
import LandingPageHeader from "components/Headers/MyLandingPageHeader.js";
import DemoFooter from "components/Footers/DemoFooter.js";

function LandingPage() {
  document.documentElement.classList.remove("nav-open");
  React.useEffect(() => {
    document.body.classList.add("profile-page");
    return function cleanup() {
      document.body.classList.remove("profile-page");
    };
  });
  return (
    <>
      <ExamplesNavbar />
      <LandingPageHeader />
      <div className="main" id="about">
        <div className="section text-center" style={{paddingBottom:"0%"}}>
          <Container>
            <Row>
              <Col className="ml-auto mr-auto" md="8">
                <h2 className="title">Let's talk about our product</h2>
                <h5 className="description">
                  In this prduct we are presenting a new solution to purchases that are made offline. 
                  Specifically, we are working with inflight purchases. Right now, the current solution 
                  involves passengers to pay with cash or use their credit card. However, using cash is not 
                  always suitable since change can not be available. Also, credit card transactions cannot
                  be completed on the air when there is no internet. Therefore, it is the flight cabins
                  responsibility to control the transactions when the plane lands and fix any problems with
                  the passenger. Moreover, there can be more problems with returns. This method is inefficient
                  and in this project, we proposed a new approach to this problem. In flight purchases can be
                  done with a QR code or ID card of the passenger because  the passenger created a provision
                  before the flight. With this provision, we ensure the airlines that the passenger has the
                  money in their account and after the flight, the transaction will be successful. Similarly,
                  in flight returns can be done easier offline. With this work, we presented a <b>reliable, certain
                  and novel solution.</b>   </h5>
                <br />
               
              </Col>
            </Row>
          </Container>
        </div>

        <div className="section-dark text-center" style={{paddingTop: "0.5%", paddingBottom:"0%"}}>
          <Container >
          <h2 className="title">Meet with the Team!</h2> <br /> <br />
            <Row>
              <Col md="3">
                <Card className="card-profile card-plain">
                  <div className="card-avatar">
                    <a>
                      <img
                        alt="..."
                        src={require("assets/img/faces/kd.jpg")}
                      />
                    </a>
                  </div>
                  <CardBody>
                    <a>
                      <div className="author">
                        <CardTitle tag="h4">Ahmet Talha Akgül</CardTitle>
                        <h6 className="card-category">Developer</h6>
                      </div>
                    </a>
                  </CardBody>
                </Card>
              </Col>
              <Col md="3">
                <Card className="card-profile card-plain">
                  <div className="card-avatar">
                    <a>
                      <img
                        alt="..."
                        src={require("assets/img/faces/kd.jpg")}
                      />
                    </a>
                  </div>
                  <CardBody>
                    <a>
                      <div className="author">
                        <CardTitle tag="h4">Betül Demirtaş</CardTitle>
                        <h6 className="card-category">Developer</h6>
                      </div>
                    </a>
                  </CardBody>
                </Card>
              </Col>
              <Col md="3">
                <Card className="card-profile card-plain">
                  <div className="card-avatar">
                    <a>
                      <img
                        alt="..."
                        src={require("assets/img/faces/kd.jpg")}
                      />
                    </a>
                  </div>
                  <CardBody>
                    <a>
                      <div className="author">
                        <CardTitle tag="h4">Doğa Ege İnhanlı</CardTitle>
                        <h6 className="card-category">Developer</h6>
                      </div>
                    </a>
                  </CardBody>
                </Card>
              </Col>
              <Col md="3">
                <Card className="card-profile card-plain">
                  <div className="card-avatar">
                    <a>
                      <img
                        alt="..."
                        src={require("assets/img/faces/kd.jpg")}
                      />
                    </a>
                  </div>
                  <CardBody>
                    <a>
                      <div className="author">
                        <CardTitle tag="h4">Pınar Erbil</CardTitle>
                        <h6 className="card-category">Developer</h6>
                      </div>
                    </a>
                  </CardBody>
                </Card>
              </Col>
            </Row>            
          </Container>
        </div>

        <div className="section landing-section" id="contact-us">
          <Container>
            <Row>
              <Col className="ml-auto mr-auto" md="8">
                <h2 className="text-center">Keep in touch?</h2>
                <Form className="contact-form">
                  <Row>
                    <Col md="6">
                      <label>Name</label>
                      <InputGroup>
                        <InputGroupAddon addonType="prepend">
                          <InputGroupText>
                            <i className="nc-icon nc-single-02" />
                          </InputGroupText>
                        </InputGroupAddon>
                        <Input placeholder="Name" type="text" />
                      </InputGroup>
                    </Col>
                    <Col md="6">
                      <label>Email</label>
                      <InputGroup>
                        <InputGroupAddon addonType="prepend">
                          <InputGroupText>
                            <i className="nc-icon nc-email-85" />
                          </InputGroupText>
                        </InputGroupAddon>
                        <Input placeholder="Email" type="text" />
                      </InputGroup>
                    </Col>
                  </Row>
                  <label>Message</label>
                  <Input
                    placeholder="Tell us your thoughts and feelings..."
                    type="textarea"
                    rows="4"
                  />
                  <Row>
                    <Col className="ml-auto mr-auto" md="4">
                      <Button className="btn-fill" color="danger" size="lg">
                        Send Message
                      </Button>
                    </Col>
                  </Row>
                </Form>
              </Col>
            </Row>
          </Container>
        </div>
      </div>
      <DemoFooter />
    </>
  );
}

export default LandingPage;
