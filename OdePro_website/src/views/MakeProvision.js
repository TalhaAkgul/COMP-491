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
import { useState, useRef } from "react";

import Cleave from "cleave.js/react";
import anime from "animejs/lib/anime.es.js";
import "assets/css/card.css";
import "assets/css/card.css";

import {
  FaCcAmex,
  FaCcDinersClub,
  FaCcDiscover,
  FaCcJcb,
  FaCcMastercard,
  FaCcVisa,
  FaCreditCard,
} from "react-icons/fa";

// reactstrap components

import {
  Button,
  Label,
  FormGroup,
  Input,
  Card,
  CardBody,
  CardHeader,
  NavItem,
  NavLink,
  Nav,
  TabContent,
  TabPane,
  Form,
  Container,
  Row,
  Col,
} from "reactstrap";

// core components
import ExamplesNavbar from "components/Navbars/MyNavbar.js";
import ProfilePageHeader from "components/Headers/ProfilePageHeader.js";
import DemoFooter from "components/Footers/DemoFooter.js";

function ProfilePage() {
  document.documentElement.classList.remove("nav-open");
  React.useEffect(() => {
    document.body.classList.add("landing-page");
    return function cleanup() {
      document.body.classList.remove("landing-page");
    };
  });
  const [activeTab, setActiveTab] = React.useState("1");

  var [name, setName] = useState("");
  const [errorMessageName, setErrorMessageName] = useState("");
  var [surname, setSurname] = useState("");
  const [errorMessageSurname, setErrorMessageSurname] = useState("");
  var [email, setEmail] = useState("");
  const [errorMessageEmail, setErrorMessageEmail] = useState("");
  var [callSign, setCallSign] = useState("");
  const [errorMessageCallSign, setErrorMessageCallSign] = useState("");
  var [flightNo, setFlightNo] = useState("");
  const [errorMessageFlightNo, setErrorMessageFlightNo] = useState("");

  const [cardNumber] = useState("");
  const [cardHolderName, setCardHolderName] = useState("");
  const [expirationDate, setExpirationDate] = useState("");
  const [cvv, setCvv] = useState("");
  const [cardType, setCardType] = useState("");

  // Controlled inputs
  const setCardNumber = (e) => {
    if (e.substring(0, 1) === "4") {
      setCardType("Visa");
    } else if (e.substring(0, 4) === "6011") {
      setCardType("Discover");
    } else if (e.substring(0, 2) === "51") {
      setCardType("MasterCard");
    } else if (e.substring(0, 2) === "34") {
      setCardType("AmericanExpress");
    } else if (e.substring(0, 3) === "300") {
      setCardType("DinersClub");
    } else if (e.substring(0, 2) === "35") {
      setCardType("JCB");
    } else {
      setCardType("");
    }
  };

  const toggle = (tab) => {
    if (activeTab === "1" && tab === "2") {
      //next
      var bool = 1;
      const pattern =
        /^[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*$/; // regex to allow only letters
      if (pattern.test(email)) {
        setEmail(email);
        setErrorMessageEmail("");
      } else {
        bool = 0;
        setEmail("");
        setErrorMessageEmail("Input must be a form of email");
      }

      if (!name || !surname || !email || !callSign || !flightNo || !bool) {
        alert("Please check your information");
      } else {
        setActiveTab(tab);
      }
    }

    if (activeTab === "2" && tab === "2") {
      //submit
      handleSubmit();
    }
    if (activeTab === "2" && tab === "1") {
      setActiveTab(tab);
    }
  };

  // Flip card animations
  const flipCard = () => {
    anime({
      targets: ".credit-card-inner",
      rotateY: "180deg",
      duration: "100",
      easing: "linear",
    });
  };
  const unFlipCard = () => {
    anime({
      targets: ".credit-card-inner",
      rotateY: "360deg",
      duration: "100",
      easing: "linear",
    });
  };

  const handleSubmit = async () => {
    const data = {
      name,
      surname,
      email,
      callSign,
      flightNo,
      cardNumber,
      cardHolderName,
      expirationDate,
      cvv,
    };

    const response = await fetch("https://172.16.146.4:8080/deneme", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    });

    if (response.ok) {
      alert("Form submitted successfully");
    } else {
      alert("Form submission failed");
    }
    //e.target.reset();
  };

  return (
    <>
      <ExamplesNavbar />
      <ProfilePageHeader />
      <div className="section profile-content">
        <Container>
          <br />
          <br />
          <br />
          <form onSubmit={handleSubmit}>
            <Card>
              <CardHeader></CardHeader>
              <CardBody
                className="col-md"
                style={{ margin: "0 0 0 20%", width: "60%" }}
              >
                <TabContent activeTab={activeTab}>
                  <TabPane tabId="1">
                    <FormGroup>
                      <Row>
                        <Col>
                          <Label for="text">Name</Label>
                          <Input
                            type="text"
                            id="name"
                            value={name}
                            required="'required'"
                            onChange={(e) => {
                              const pattern = /^[A-Za-zıöçşğü ]*$/; // regex to allow only letters
                              if (pattern.test(e.target.value)) {
                                setName(e.target.value);
                                setErrorMessageName("");
                              } else {
                                setErrorMessageName(
                                  "Input must contain only letters"
                                );
                              }
                            }}
                            placeholder="Name"
                          />
                          {errorMessageName && (
                            <span style={{ color: "red" }}>
                              {errorMessageName}
                            </span>
                          )}
                        </Col>
                        <Col>
                          <Label for="Surname">Surname</Label>
                          <Input
                            type="text"
                            id="surname"
                            value={surname}
                            required="'required'"
                            onChange={(e) => {
                              const pattern = /^[A-Za-zıöçşğü ]*$/; // regex to allow only letters
                              if (pattern.test(e.target.value)) {
                                setSurname(e.target.value);
                                setErrorMessageSurname("");
                              } else {
                                setErrorMessageSurname(
                                  "Input must contain only letters"
                                );
                              }
                            }}
                            placeholder="Surname"
                          />
                          {errorMessageSurname && (
                            <span style={{ color: "red" }}>
                              {errorMessageSurname}
                            </span>
                          )}
                        </Col>
                      </Row>
                    </FormGroup>
                    <FormGroup>
                      <Row>
                        <Col>
                          <Label for="inputEmail">Email</Label>
                          <Input
                            type="text"
                            id="inputEmail"
                            onChange={(e) => setEmail(e.target.value)}
                            value={email}
                            required="'required'"
                            placeholder="Email"
                          />
                          {errorMessageEmail && (
                            <span style={{ color: "red" }}>
                              {errorMessageEmail}
                            </span>
                          )}
                        </Col>
                      </Row>
                    </FormGroup>

                    <FormGroup>
                      <Row>
                        <Col>
                          <Label for="airline">Flight Number</Label>
                          <Input
                            type="text"
                            id="airline"
                            value={callSign}
                            required="'required'"
                            onChange={(e) => {
                              const pattern = /^[A-Za-z]{0,3}$/; // regex to allow only letters
                              if (pattern.test(e.target.value)) {
                                setCallSign(e.target.value);
                                setErrorMessageCallSign("");
                              } else {
                                setErrorMessageCallSign(
                                  "Input must contain only letters"
                                );
                              }
                            }}
                            placeholder="Initials"
                          />
                          {errorMessageCallSign && (
                            <span style={{ color: "red" }}>
                              {errorMessageCallSign}
                            </span>
                          )}
                        </Col>
                        <Col>
                          <Label for="airline" style={{ opacity: 0 }}>
                            this is a hidden element
                          </Label>

                          <Input
                            type="text"
                            title="Numbers Only"
                            value={flightNo}
                            id="flightnum"
                            required="'required'"
                            onChange={(e) => {
                              const pattern = /^[0-9]*$/; // regex to allow only letters
                              if (pattern.test(e.target.value)) {
                                setFlightNo(e.target.value);
                                setErrorMessageFlightNo("");
                              } else {
                                setErrorMessageFlightNo(
                                  "Input must contain only letters"
                                );
                              }
                            }}
                            placeholder="Number"
                          />
                          {errorMessageFlightNo && (
                            <span style={{ color: "red" }}>
                              {errorMessageFlightNo}
                            </span>
                          )}
                        </Col>
                      </Row>
                    </FormGroup>
                  </TabPane>
                  <TabPane tabId="2">
                    <FormGroup>
                      <Row>
                        <Col>
                          <div className="credit-card-container">
                            <div
                              className="credit-card"
                              style={{ margin: "0 12% 0 12%", width: "76%" }}
                            >
                              <div className="credit-card-inner">
                                <div className="credit-card-front">
                                  <div id="credit-card-type">
                                    {cardType === "" && <FaCreditCard />}
                                    {cardType === "Discover" && (
                                      <FaCcDiscover />
                                    )}
                                    {cardType === "AmericanExpress" && (
                                      <FaCcAmex />
                                    )}
                                    {cardType === "Visa" && <FaCcVisa />}
                                    {cardType === "DinersClub" && (
                                      <FaCcDinersClub />
                                    )}
                                    {cardType === "JCB" && <FaCcJcb />}
                                    {cardType === "MasterCard" && (
                                      <FaCcMastercard />
                                    )}
                                  </div>
                                  <div id="credit-card-number">
                                    {cardNumber == "" && (
                                      <div id="credit-card-number">
                                        0000 0000 0000 0000
                                      </div>
                                    )}
                                    {cardNumber}
                                  </div>

                                  <div id="credit-card-expiration">
                                    {expirationDate !== "" && (
                                      <div id="credit-card-validthru">
                                        Valid Thru
                                      </div>
                                    )}
                                    {expirationDate}
                                  </div>

                                  <div id="credit-card-holder-name">
                                    {cardHolderName == "" && (
                                      <div id="credit-card-holder-name">
                                        {" "}
                                        YOUR NAME
                                      </div>
                                    )}
                                    {cardHolderName}
                                  </div>
                                </div>
                                <div className="credit-card-back">
                                  <div className="credit-card-stripe" />
                                  <div className="credit-card-sig-container">
                                    <div className="credit-card-signature">
                                      {cardHolderName}
                                    </div>
                                    CVC {cvv}
                                  </div>
                                  <p className="credit-card-credits">
                                    Built with Cleave.js, Anime.js, and React
                                    Icons.
                                  </p>
                                </div>
                              </div>
                            </div>
                            <form
                              className="credit-card-form"
                              style={{ margin: "5% 5% 0 5%", width: "90%" }}
                            >
                              <label className="credit-card-input-label">
                                Credit Card Number
                              </label>
                              <Cleave
                                placeholder="Enter your credit card number"
                                options={{ creditCard: true }}
                                id="number-input"
                                name="number-input"
                                className="credit-card-text-input"
                                required="'required'"
                                onChange={(e) => setCardNumber(e.target.value)}
                              />
                              <label className="credit-card-input-label">
                                Card Holder Name
                              </label>
                              <input
                                type="text"
                                placeholder="Enter card holder name"
                                value={cardHolderName}
                                required="'required'"
                                onChange={(e) =>
                                  setCardHolderName(e.target.value)
                                }
                                className="credit-card-text-input"
                                maxLength="30"
                              />
                              <div
                                className="date-and-csv"
                                style={{ display: "flex" }}
                              >
                                <div
                                  style={{
                                    display: "flex",
                                    flexDirection: "column",
                                    width: "50%",
                                  }}
                                >
                                  <label className="credit-card-input-label">
                                    Expiration Date
                                  </label>
                                  <Cleave
                                    options={{
                                      date: "true",
                                      delimiter: "/",
                                      datePattern: ["m", "y"],
                                    }}
                                    placeholder="Enter expiration date"
                                    value={expirationDate}
                                    className="credit-card-text-input"
                                    required="'required'"
                                    onChange={(e) =>
                                      setExpirationDate(e.target.value)
                                    }
                                  />
                                </div>
                                <div
                                  style={{
                                    display: "flex",
                                    flexDirection: "column",
                                    width: "50%",
                                  }}
                                >
                                  <label className="credit-card-input-label">
                                    CVC Security Code
                                  </label>
                                  <Cleave
                                    options={{
                                      numeral: "true",
                                    }}
                                    placeholder="Enter CVC"
                                    maxLength="3"
                                    value={cvv}
                                    className="credit-card-text-input"
                                    required="'required'"
                                    onChange={(e) => setCvv(e.target.value)}
                                    onFocus={flipCard}
                                    onBlur={unFlipCard}
                                  />
                                </div>
                              </div>
                            </form>
                          </div>
                        </Col>
                      </Row>
                    </FormGroup>
                  </TabPane>
                </TabContent>
              </CardBody>
              <CardHeader>
                <Nav pills className="justify-content-center">
                  <Nav tabs activeTab={activeTab}>
                    <NavItem style={{ margin: "0 1rem 0  0" }}>
                      <Button
                        className="btn-round"
                        color="danger"
                        size="lg"
                        onClick={() => {
                          toggle("1");
                        }}
                        href="#"
                      >
                        Prev
                      </Button>
                    </NavItem>
                    <NavItem>
                      <Button
                        className="btn-round"
                        type="submit"
                        color="danger"
                        size="lg"
                        onClick={() => {
                          toggle("2");
                        }}
                        href="#"
                      >
                        {activeTab === "2" ? "Submit" : "Next"}
                      </Button>
                    </NavItem>
                  </Nav>
                </Nav>
              </CardHeader>
            </Card>
          </form>

          <br />
        </Container>
      </div>
      <DemoFooter />
    </>
  );
}

export default ProfilePage;
