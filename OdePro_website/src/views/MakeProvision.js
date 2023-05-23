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
  Modal,
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
  var [IDNumber, setIDNumber] = useState("");
  const [errorMessageIDNumber, setErrorMessageIDNumber] = useState("");
  var [email, setEmail] = useState("");
  const [errorMessageEmail, setErrorMessageEmail] = useState("");
  var [phoneNo, setPhoneNo] = useState("");
  const [errorMessagePhoneNo, setErrorMessagePhoneNo] = useState("");
  var [address, setAddress] = useState("");
  const [errorMessageAddress, setErrorMessageAddress] = useState("");
  var [callSign, setCallSign] = useState("");
  const [errorMessageCallSign, setErrorMessageCallSign] = useState("");
  var [flightNo, setFlightNo] = useState("");
  const [errorMessageFlightNo, setErrorMessageFlightNo] = useState("");
  const [errorMessage, setErrorMessage] = useState("");

  const [cardNumber, setCardNumber] = useState("");
  const [cardHolderName, setCardHolderName] = useState("");
  const [expirationDate, setExpirationDate] = useState("");
  const [cvv, setCvv] = useState("");
  const [cardType, setCardType] = useState("");
  const [provisionAmount, setProvisionAmount] = useState("");

  const [liveDemo, setLiveDemo] = React.useState(false);
  const [err, setErr] = useState("");
  const [liveDemoOk, setLiveDemoOk] = React.useState(false);
  const [errOk, setErrOk] = useState("");
  const [nextOk, setNextOk] = useState("");
  const [submitOk, setSubmitOk] = useState("");

  // Controlled inputs
  const setCardNumberandType = (e) => {
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
    setCardNumber(e);
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

      if (!name || !surname || !IDNumber || !email || !phoneNo || !callSign || !flightNo || !bool
        || errorMessageName || errorMessageSurname || errorMessageIDNumber || errorMessageEmail || errorMessagePhoneNo
        || errorMessageAddress || errorMessageCallSign || errorMessageFlightNo) {
        setNextOk("true");
      } else {
        setActiveTab(tab);
      }
    }

    if (activeTab === "2" && tab === "2") {
      //submit
      const patternCardNumber = /^[0-9 ]{19}$/; 
      const patternCardHolderName = /^[A-Za-z/ ]{50}$/; 
      const patternCvv = /^[0-9]{3}$/; 
      const patternDate = /^[0-9/]{5}$/; 
      //|| !patternCardHolderName.test(cardHolderName)  || !patternCvv.test(cvv)
      //|| !patternDate.test(expirationDate) || !provisionAmount
      if (!patternCardNumber.test(cardNumber) )
      {
        setSubmitOk("true");
      }else {
        handleSubmit();
      }
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
    const tempCardNumber = cardNumber.replaceAll(' ', '');
    const tempProvisionNumber = provisionAmount.replaceAll(',', '');
    const tempName = name.toLowerCase().replaceAll("ı", "i").replaceAll("ğ", "g").replaceAll("ü", "u").replaceAll("ş", "s").replaceAll("ö", "o").replaceAll("ç", "c");
    const tempSurname = surname.toLowerCase().replaceAll("ı", "i").replaceAll("ğ", "g").replaceAll("ü", "u").replaceAll("ş", "s").replaceAll("ö", "o").replaceAll("ç", "c");
    const tempAddress = address.toLowerCase();
    const tempCardHolderName = cardHolderName.toLowerCase().replaceAll("ı", "i").replaceAll("ğ", "g").replaceAll("ü", "u").replaceAll("ş", "s").replaceAll("ö", "o").replaceAll("ç", "c");
    const tempFullFlightInfo = callSign + flightNo;
    const data = {
      passengerName: tempName,
      passengerSurname: tempSurname,
      passengerPID: IDNumber,
      passengerEmail: email,
      passengerPhoneNumber: phoneNo,
      passengerAddress: tempAddress,
      flightNo: tempFullFlightInfo,
      creditCardNo: tempCardNumber,
      cardHolder: tempCardHolderName,
      expiration: expirationDate,
      cvc: cvv,
      amount: tempProvisionNumber,
    };
    fetch('https://172.20.56.202:8080/payment', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    })
      .then(async response => {
        if (response.ok) {
          // Provision is opened successfully
          const errOk = await response.text();
          setErrOk(errOk);
          setLiveDemoOk(true);
          
        }  else {
          const err = await response.text();
          setErr(err);
          setLiveDemo(true);
        }
      })
      
  }

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
                        <Col style={{
                                    display: "flex",
                                    flexDirection: "column",
                                    width: "50%",
                                  }}>
                          <Label className="credit-card-input-label" for="text">Name</Label>
                          <Cleave
                            type="text"
                            id="name"
                            className="credit-card-text-input"
                            value={name}
                            maxlength="30"
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
                            placeholder="Enter Your Name"
                          />
                          {errorMessageName && (
                            <span style={{ color: "red" }}>
                              {errorMessageName}
                            </span>
                          )}
                        </Col>
                        <Col style={{
                                    display: "flex",
                                    flexDirection: "column",
                                    width: "50%",
                                  }}>
                          <Label className="credit-card-input-label" for="Surname">Surname</Label>
                          <Cleave
                            type="text"
                            id="surname"
                            className="credit-card-text-input"
                            maxlength="30"
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
                            placeholder="Enter Your Surname"
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
                        <Col style={{
                                    display: "flex",
                                    flexDirection: "column",
                                    width: "100%",
                                  }}>
                          <Label className="credit-card-input-label" for="inputIDName">ID number</Label>
                          <Cleave
                            type="text"
                            className="credit-card-text-input"
                            id="IDNumber"
                            maxlength="11"
                            value={IDNumber}
                            required="'required'"
                            onChange={(e) => {
                              const pattern = /^[0-9]*$/; // regex to allow only letters
                              if (pattern.test(e.target.value)) {
                                setIDNumber(e.target.value);
                                setErrorMessageIDNumber("");
                              } else {
                                setErrorMessageIDNumber(
                                  "Input must contain only letters"
                                );
                              }
                            }}
                            placeholder="Enter Your ID Number"
                          />
                          {errorMessageIDNumber && (
                            <span style={{ color: "red" }}>
                              {errorMessageIDNumber}
                            </span>
                          )}
                        </Col>
                      </Row>
                    </FormGroup>
                    <FormGroup>
                      <Row>
                        <Col style={{
                                    display: "flex",
                                    flexDirection: "column",
                                    width: "50%",
                                  }}>
                          <Label className="credit-card-input-label" for="inputEmail">E-mail</Label>
                          <Cleave
                            type="email"
                            id="email"
                            className="credit-card-text-input"
                            maxlength="50"
                            onChange={(e) => setEmail(e.target.value)}
                            value={email}
                            required="'required'"
                            placeholder="Enter Your E-mail"
                          />
                          {errorMessageEmail && (
                            <span style={{ color: "red" }}>
                              {errorMessageEmail}
                            </span>
                          )}
                        </Col>
                        <Col style={{
                                    display: "flex",
                                    flexDirection: "column",
                                    width: "50%",
                                  }}>
                          <Label className="credit-card-input-label" for="inputPhoneNo">Phone Number</Label>
                         <Cleave
                            type="tel"
                            id="phoneNo"
                            className="credit-card-text-input"
                            maxlength="50"
                            onChange={(e) => {
                              const pattern = /^\+[0-9]*$/; // regex to allow only letters
                              if (pattern.test(e.target.value)) {
                                setPhoneNo(e.target.value);
                                setErrorMessagePhoneNo("");
                              } else {
                                setErrorMessagePhoneNo(
                                  "Please put the country code and then the number"
                                );
                              }
                            }}
                            value={phoneNo}
                            required="'required'"
                            placeholder="+905321511080"
                          />
                          {errorMessagePhoneNo && (
                            <span style={{ color: "red" }}>
                              {errorMessagePhoneNo}
                            </span>
                          )}
                        </Col>
                      </Row>
                    </FormGroup>
                    <FormGroup>
                      <Row>
                        <Col style={{
                                    display: "flex",
                                    flexDirection: "column",
                                    width: "100%",
                                  }}>
                          <Label className="credit-card-input-label" for="inputAddress">Address</Label>
                          <Cleave
                            type="text"
                            id="address"
                            maxlength="50"
                            className="credit-card-text-input"
                            onChange={(e) => setAddress(e.target.value)}
                            value={address}
                            required="'required'"
                            placeholder="Enter Your Address"
                          />
                          {errorMessageAddress && (
                            <span style={{ color: "red" }}>
                              {errorMessageAddress}
                            </span>
                          )}
                        </Col>
                      </Row>
                    </FormGroup>
                    <FormGroup>
                      <Row>
                        <Col style={{
                                    display: "flex",
                                    flexDirection: "column",
                                    width: "50%",
                                  }}>
                          <Label className="credit-card-input-label" for="airline">Flight Number</Label>
                          <Cleave
                            type="text"
                            id="airline"
                            className="credit-card-text-input"
                            value={callSign}
                            maxlength="3"
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
                            placeholder="Call Sign"
                          />
                          {errorMessageCallSign && (
                            <span style={{ color: "red" }}>
                              {errorMessageCallSign}
                            </span>
                          )}
                        </Col>
                        <Col style={{
                                    display: "flex",
                                    flexDirection: "column",
                                    width: "50%",
                                  }}>
                          <Label className="credit-card-input-label" for="airline" style={{ opacity: 0 }}>
                            this is a hidden element
                          </Label>

                          <Cleave
                            type="text"
                            title="Numbers Only"
                            maxlength="8"
                            className="credit-card-text-input"
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
                            placeholder="Flight Number"
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
                                  <div className="credit-card-number">
                                    {cardNumber == "" && (
                                      <div id="credit-card-number">
                                        0000 0000 0000 0000
                                      </div>
                                    )}
                                    <div id="credit-card-number">
                                    {cardNumber}
                                    </div>
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
                                value={cardNumber}
                                className="credit-card-text-input"
                                required="'required'"
                                onChange={(e) => {
                                    setCardNumberandType(e.target.value);
                                }}
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
                              <label className="credit-card-input-label">
                              Provision Amount
                              </label>
                              <Cleave
                                placeholder="Enter your desired provision amount"
                                options={{
                                  numeral: "true",
                                }}
                                id="number-input"
                                maxLength="13"
                                name="number-input"
                                value={provisionAmount}
                                className="credit-card-text-input"
                                required="'required'"
                                onChange={(e) => {
                                  const pattern = /^[0-9,.]*$/; // regex to allow only letters
                                  if (pattern.test(e.target.value)) {
                                    setProvisionAmount(e.target.value);
                                  }
                                }}
                              />
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
                        color="info"
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
                        color="info"
                        size="lg"
                        onClick={() => {
                          toggle("2");
                        }}
                        href="#"
                      >
                        {activeTab === "2" ? "Submit" : "Next"}
                      </Button>
                      <Modal isOpen={nextOk} toggle={() => setNextOk(false)}>
                        <div className="modal-header">

                        <button
                            aria-label="Close"
                            className="close"
                            data-dismiss="modal"
                            type="button"
                            onClick={() => setNextOk(false)}
                          >
                            <span aria-hidden={true}>×</span>
                          </button>
                          <h5 className="modal-title" id="exampleModalLiveLabel">
                            <b><div style={{color:"red"}}>Error</div></b>
                          </h5>
                        </div>
                        <div className="modal-body">
                        <p style={{textAlign:"center"}}>Please check your personal information!</p>
                        <button
                            aria-label="Close"
                            className="close"
                            data-dismiss="modal"
                            type="button"
                            onClick={() => setNextOk(false)}
                          >
                            <p aria-hidden={true}><b>Okay</b></p>
                          </button>
                        </div>
                      </Modal>

                      <Modal isOpen={submitOk} toggle={() => setSubmitOk(false)}>
                        <div className="modal-header">

                        <button
                            aria-label="Close"
                            className="close"
                            data-dismiss="modal"
                            type="button"
                            onClick={() => setSubmitOk(false)}
                          >
                            <span aria-hidden={true}>×</span>
                          </button>
                          <h5 className="modal-title" id="exampleModalLiveLabel">
                            <b><div style={{color:"red"}}>Error</div></b>
                          </h5>
                        </div>
                        <div className="modal-body">
                          <p style={{textAlign:"center"}}>Please check your credit card information!</p>
                          <button
                            aria-label="Close"
                            className="close"
                            data-dismiss="modal"
                            type="button"
                            onClick={() => setSubmitOk(false)}
                          >
                            <p aria-hidden={true}><b>Okay</b></p>
                            </button>
                        </div>
                      </Modal>
                      <Modal isOpen={liveDemo} toggle={() => setLiveDemo(false)}>
                      <div className="modal-header">

                      <button
                          aria-label="Close"
                          className="close"
                          data-dismiss="modal"
                          type="button"
                          onClick={() => setLiveDemo(false)}
                        >
                          <span aria-hidden={true}>×</span>
                        </button>
                        <h5 className="modal-title" id="exampleModalLiveLabel">
                          <b><div style={{color:"red"}}>Error</div></b>
                        </h5>
                      </div>
                      <div className="modal-body">
                        <p style={{textAlign:"center"}} > <b>{err}</b></p>
                        <button
                          aria-label="Close"
                          className="close"
                          data-dismiss="modal"
                          type="button"
                          onClick={() => setLiveDemo(false)}
                        >
                            <p aria-hidden={true}><b>Okay</b></p>
                        </button>
                      </div>
                    </Modal>
                    <Modal isOpen={liveDemoOk} toggle={() => setLiveDemoOk(false)}>
                      <div className="modal-header">

                      <button
                          aria-label="Close"
                          className="close"
                          data-dismiss="modal"
                          type="button"
                          onClick={() => {setLiveDemoOk(false); window.location = 'my-landing-page'}}
                        >
                          <span aria-hidden={true}>×</span>
                        </button>
                        <h5 className="modal-title" id="exampleModalLiveLabel">
                          <b><div style={{color:"green"}}>Success!</div></b>
                        </h5>
                      </div>
                      <div className="modal-body">
                        <p style={{textAlign:"center"}} > <b>{errOk}</b></p>
                        <button
                          aria-label="Close"
                          className="close"
                          data-dismiss="modal"
                          type="button"
                          onClick={() => {setLiveDemoOk(false); window.location = 'my-landing-page'}}
                        >
                          <p aria-hidden={true}> <b>Okay</b></p>
                        </button>
                      </div>
                    </Modal>
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
