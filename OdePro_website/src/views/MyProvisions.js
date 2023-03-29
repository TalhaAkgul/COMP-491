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
import { useState } from "react";
import ProvisionActive from './ProvisionActive'
import ProvisionUsed from './ProvisionUsed'

// reactstrap components
import {
  Button,
  Label,
  FormGroup,
  Input,
  NavItem,
  NavLink,
  Nav,
  TabContent,
  TabPane,
  Container,
  Row,
  Col, 
  Card,
  CardHeader, 
  CardBody, 
  CardTitle, 
  CardText
} from "reactstrap";

// core components
import ExamplesNavbar from "components/Navbars/MyNavbar.js";
import ProfilePageHeader from "components/Headers/ProfilePageHeader.js";
import DemoFooter from "components/Footers/DemoFooter.js";

function ProfilePage() {

  const [activeTab, setActiveTab] = React.useState("1");
  var [name, surname, id] = useState("");
  const toggle = (tab) => {
    if (activeTab !== tab) {
      setActiveTab(tab);
    }
  };

  document.documentElement.classList.remove("nav-open");
  React.useEffect(() => {
    document.body.classList.add("landing-page");
    return function cleanup() {
      document.body.classList.remove("landing-page");
    };
  });


const handleSubmit = (event) => {
  event.preventDefault();
  Array.from(event.target).forEach((e) => (e.value = ""));
  alert(`The name you entered was: ${name}, ${surname}, ${id}`);
  name = "";
  surname = "";
  id = "";
}
  const setName = (event) => {
    name = event;
  }

  const setSurname = (event) => {
    surname = event;
  }

  const setID = (event) => {
    id = event;
  }

  return (
    <>
      <ExamplesNavbar />
      <ProfilePageHeader />
      <div className="section profile-content">
        <Container>
          <div>
            <div className="name">
              <h3 className="title">
                <br /> Search Your Provisions <br />
              </h3>
            </div>
          </div>
          <form onSubmit={handleSubmit}>
            <div className="form-row center">
              <FormGroup className="col-md-4">
                <Label for="inputName">Name</Label>
                <Input type="text" onChange={(e) => setName(e.target.value)} id="inputName" placeholder="Name"/>
              </FormGroup>
              <FormGroup className="col-sm-4">
                <Label for="inputSurname">Surname</Label>
                <Input type="text" onChange={(e) => setSurname(e.target.value)} id="inputSurname" placeholder="Surname"/>
              </FormGroup>
              <FormGroup className="col-md-4">
                <Label>Identity Number</Label>
                <Input type="text" onChange={(e) => setID(e.target.value)}id="inputID" placeholder="Identity Number"/>
              </FormGroup>
            
            </div>
            <Button className="btn-round" type="submit" color="info">
                <i className="fa fa-search" /> Search </Button>
          </form>
          <br />
          <br />

          <Card className="text-center">
            <CardHeader>
              <div className="nav-tabs-navigation">
                <div className="nav-tabs-wrapper">
                  <Nav tabs activeTab={activeTab}>
                    <NavItem>
                      <NavLink className={activeTab === "1" ? "active" : ""}
                    onClick={() => {
                      toggle("1");
                    }}
                    href="#">
                        Active
                      </NavLink>
                    </NavItem>
                    <NavItem>
                      <NavLink  className={activeTab === "2" ? "active" : ""}
                    onClick={() => {
                      toggle("2");
                    }}
                    href="#" >
                        Used
                      </NavLink>
                    </NavItem>
                  </Nav>
                </div>
              </div>
            </CardHeader>
            <CardBody >
             <TabContent className="following" activeTab={activeTab}>
                <TabPane tabId="1">
                  <CardText>
                <ProvisionActive />
                </CardText>
                </TabPane>
                <TabPane tabId="2">
                  <CardText>Your Used Provisions</CardText>
                  <ProvisionUsed />
                </TabPane>
                </TabContent>

            </CardBody>
          </Card>
         
        </Container>
      </div>
      <DemoFooter />
    </>
  );
  
}

export default ProfilePage;
