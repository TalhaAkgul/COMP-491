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
import { GoogleMap, LoadScript } from "@react-google-maps/api"
// reactstrap components
import {
  Card,
  CardBody,
  CardTitle,
  Container,
  Row,
  Col,
} from "reactstrap";

// core components
import ExamplesNavbar from "components/Navbars/MyNavbar.js";
import LandingPageHeader from "components/Headers/MyLandingPageHeaderMain.js";
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
                <h2 className="title" style={{color:"#51cbce"}}>Let's talk about our product</h2>
                <h4 className="description">
                  In this prduct we are presenting a <b style={{color:"#51bcda"}}>new solution</b> to inflight purchases that are made offline. 
                  The current solutions involve passengers to pay with cash or use their credit card 
                  but it is problematic and not efficient for multiple transactions
                  <br /><br />
                  We propose a platform that can make inflight purchases via <b style={{color:"#6bd098"}}>QR code</b> or <b style={{color:"#6bd098"}}>ID card</b>.
                  <br /><br />
                  By making a provision prior to the flight, we ensure that you have sufficient money in your bank account.
                  With our platform, all the transactions are sucessfull and we presented a <b style={{color:"#fbc658"}}>reliable, certain
                  </b> and <b style={{color:"#fbc658"}}> novel solution.</b> 
                  <br /><br />
                  This project is for Koç University Comp491 - Computer Engineering Design course
                  <br /><br />
                  Supervised by: <b style={{color:"#F5593D"}}>Prof. Çiğdem Gündüz Demir</b>  </h4>
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
                        src={require("assets/img/faces/talha.jpg")}
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
                        src={require("assets/img/faces/betul.jpg")}
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
                        src={require("assets/img/faces/ege.jpg")}
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
                        src={require("assets/img/faces/pinar.jpg")}
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
              <Col>
              <Card>
              <CardBody>
              <h2 className="text-center" style={{color:"#51bcda"}}>Keep in touch?</h2>
                <hr></hr>
                <h4 style={{color:"#51bcda"}}><b>Send us an e-mail</b></h4> 
                <h5 > <b>Ahmet Talha Akgül:</b> aakgul18@ku.edu.tr</h5>
                <h5 > <b>Betül Demirtaş:</b> bdemirtas18@ku.edu.tr</h5>
                <h5 > <b>Doğa Ege İnhanlı:</b> dinhanli18@ku.edu.tr</h5>
                <h5 > <b>Pınar Erbil:</b> perbil18@ku.edu.tr</h5>
                <h4 style={{color:"#51bcda"}}><b>Or come visit us!</b></h4> 
                <h5 ><b>Koç University</b>, Sarıyer, Istanbul, Turkey, 34450</h5>
                </CardBody>
              </Card>
              </Col>
              
              <Col className="ml-auto mr-auto" md="7">
              <LoadScript
               googleMapsApiKey={process.env.REACT_APP_GOOGLE_MAPS_API_KEY}
              >
                <GoogleMap
                  mapContainerStyle={{ height: "100%", width: "100%" }}
                  center={{ lat: 41.20615902212527, lng:  29.073038862502457 }}
                  zoom={15}
                  
                />
              </LoadScript>
              
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
