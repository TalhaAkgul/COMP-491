import React from "react";
import { useState } from "react";

import Table from "@mui/material/Table";
import TableBody from "@mui/material/TableBody";
import TableCell from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TableHead from "@mui/material/TableHead";
import TableRow from "@mui/material/TableRow";
import Paper from "@mui/material/Paper";

// reactstrap components
import {
  Button,
  Label,
  FormGroup,
  NavItem,
  NavLink,
  Nav,
  TabContent,
  TabPane,
  Container,
  Card,
  CardHeader,
  CardBody,
  CardText,
  Modal
} from "reactstrap";

// core components
import ExamplesNavbar from "components/Navbars/MyNavbar.js";
import ProfilePageHeader from "components/Headers/ProfilePageHeader.js";
import DemoFooter from "components/Footers/DemoFooter.js";
import Cleave from "cleave.js/react";

function MyProvisionsPage() {
  const [activeTab, setActivetab] = React.useState("1");
  var [id, setId] = useState("");
  const [errorMessageIDNumber, setErrorMessageIDNumber] = useState("");
  var [search, setSearch] = useState("");
  const [usersActive, setUsersActive] = useState([]);
  const [usersUsed, setUsersUsed] = useState([]);
  const [liveDemo, setLiveDemo] = React.useState(false);
  const [ok, setOk] = useState(false);

  const toggle = (tab) => {
    if (activeTab !== tab) {
      setActivetab(tab);
    }
  };

  const deleteProvision = (del) => {
    setLiveDemo(true);
    if (del == true){
      {
        fetch("https://172.20.60.67:8080/deleteActiveProvision?id=" + search)
        .then((response) => response.json());
      }
      setUsersActive([]);
      {
        fetch("https://172.20.60.67:8080/getActiveProvision?id=" + search)
          .then((response) => response.json())
          .then((data) => setUsersActive(data));
      }
      setOk(true);
    }
  }

  const handleSubmit = (e) => {
    e.preventDefault();
    if (id){
      setSearch(id);
      setUsersActive([]);
      setUsersUsed([]);
      {
        fetch("https://172.20.60.67:8080/getActiveProvision?id=" + id)
          .then((response) => response.json())
          .then((data) => setUsersActive(data));
      }
      {
        fetch("https://172.20.60.67:8080/getUsedProvisions?id=" + id)
          .then((response) => response.json())
          .then((data) => setUsersUsed(data));
      }
      setId("");
    }
    e.target.reset();
  };
  
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
            <FormGroup className="col-md-4"></FormGroup>

              <FormGroup className="col-md-4">
                <Label className="credit-card-input-label" for="inputID">Identity Number</Label>
                <Cleave
                  type="text"
                  maxLength="11"
                  className="credit-card-text-input"
                  id="inputID"
                  value={id}
                  placeholder="Enter Your Identity Number"
                  onChange={(e) => {
                    const pattern = /^[0-9]*$/; // regex to allow only letters
                    if (pattern.test(e.target.value)) {
                      setId(e.target.value);
                      setErrorMessageIDNumber("");
                    } else {
                      setErrorMessageIDNumber(
                        "Input must contain only digits"
                      );
                    }
                  }}
                />
                
                {errorMessageIDNumber && (
                  <span style={{ color: "red" }}>
                    <br></br>
                    {errorMessageIDNumber}
                  </span>
                )}
              </FormGroup>
              <FormGroup className="col-md-2">
              <Label className="credit-card-input-label" for="airline" style={{ opacity: 0}}>
              this is a long hidden element
            </Label>
                    <br></br>
              <Button className="btn-round" type="submit" color="info">
              <i className="fa fa-search" /> Search{" "}
            </Button>
              </FormGroup>
            </div>
          </form>
          <br />
          <br />

          <Card className="text-center">
            <CardHeader>
              <div className="nav-tabs-navigation">
                <div className="nav-tabs-wrapper">
                  <Nav tabs activeTab={activeTab}>
                    <NavItem>
                      <NavLink
                        className={activeTab === "1" ? "active" : ""}
                        onClick={() => {
                          toggle("1");
                        }}
                        href="#"
                      >
                        Active
                      </NavLink>
                    </NavItem>
                    <NavItem>
                      <NavLink
                        className={activeTab === "2" ? "active" : ""}
                        onClick={() => {
                          toggle("2");
                        }}
                        href="#"
                      >
                        Used
                      </NavLink>
                    </NavItem>
                  </Nav>
                </div>
              </div>
            </CardHeader>
            <CardBody>
              <TabContent className="following" activeTab={activeTab}>
                <TabPane tabId="1">
                  {(!search || !usersActive[0]) && (
                    <CardText>You don't have any active provisions</CardText>
                  )}
                  {search && usersActive[0] && (
                    <TableContainer component={Paper}>
                      <Table sx={{ minWidth: 650 }} aria-label="simple table">
                        <TableHead>
                          <TableRow>
                            <TableCell align="left">ID Number</TableCell>
                            <TableCell align="left">Name</TableCell>
                            <TableCell align="left">Surname</TableCell>
                            <TableCell align="left">Email Address</TableCell>
                            <TableCell align="left">Phone Number</TableCell>
                            <TableCell align="left">Address</TableCell>
                            <TableCell align="left">Flight Info</TableCell>
                            <TableCell align="left">Provision Amount</TableCell>
                            <TableCell align="left">Card Details</TableCell>
                            <TableCell align="left">Provision Date</TableCell>

                          </TableRow>
                        </TableHead>
                        <TableBody>
                          {usersActive.map((d) => (
                            <TableRow
                              key={d.passengerName}
                              sx={{
                                "&:last-child td, &:last-child th": {
                                  border: 0,
                                },
                              }}
                            >
                              <TableCell align="left">{d.passengerPID}</TableCell>
                              <TableCell align="left">{d.passengerName}</TableCell>
                              <TableCell align="left">{d.passengerSurname}</TableCell>
                              <TableCell align="left">{d.passengerEmail}</TableCell>
                              <TableCell align="left">{d.passengerPhoneNumber}</TableCell>
                              <TableCell align="left">{d.passengerAddress}</TableCell>
                              <TableCell align="left">{d.flightNo}</TableCell>
                              <TableCell align="left">{d.amount}</TableCell>
                              <TableCell align="left">{d.hiddenCardNo}</TableCell>
                              <TableCell align="left">{d.provisionDate}</TableCell>
                              <TableCell align="left">
                               <button style={{ backgroundColor:"transparent",  border:"none"}}
                                  onClick={() => {
                                    deleteProvision(false);
                                  }}>
                                <i class="fa fa-trash-o" style={{fontSize:"200%", color:"red", cursor:"pointer"}}></i>
                              </button>
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
                                    <b><div style={{color:"red"}}>Are you sure to delete this active provision?</div></b>
                                  </h5>
                                </div>
                                <div className="modal-body" style={{ display: 'flex', justifyContent: 'center' }}>
                                  <Button className="btn-round" type="submit" color="info"
                                    onClick={() => {deleteProvision(true); setLiveDemo(false)}}
                                    style={{ marginRight: '10px' }}>Yes</Button>
                                  <Button className="btn-round" type="submit" color="info"
                                    onClick={() => {setLiveDemo(false); }}>No</Button>
                                </div>
                              </Modal>
                              <Modal isOpen={ok} toggle={() => setOk(false)}>
                                <div className="modal-header">

                                <button
                                    aria-label="Close"
                                    className="close"
                                    data-dismiss="modal"
                                    type="button"
                                    onClick={() => setOk(false)}
                                  >
                                    <span aria-hidden={true}>×</span>
                                  </button>
                                  <h5 className="modal-title" id="exampleModalLiveLabel">
                                    <b><div style={{color:"green"}}>Your provision is successfully deleted.</div></b>
                                  </h5>
                                </div>
                                <div className="modal-body" style={{ display: 'flex', justifyContent: 'center' }}>
                                  <Button className="btn-round" type="submit" color="info"
                                    onClick={() => {setOk(false);}}
                                    style={{ marginRight: '10px' }}>Close</Button>
                                </div>
                              </Modal>
                              </TableCell>
                            </TableRow>
                          ))}
                        </TableBody>
                      </Table>
                    </TableContainer>
                  )}
                </TabPane>
                <TabPane tabId="2">
                  {(!search || !usersUsed[0]) && (
                    <CardText>You don't have any used provisions</CardText>
                  )}
                  {search && usersUsed[0] && (
                    <TableContainer component={Paper}>
                      <Table sx={{ minWidth: 650 }} aria-label="simple table">
                        <TableHead>
                          <TableRow>
                            <TableCell align="left">ID Number</TableCell>
                            <TableCell align="left">Name</TableCell>
                            <TableCell align="left">Surname</TableCell>
                            <TableCell align="left">Email Address</TableCell>
                            <TableCell align="left">Phone Number</TableCell>
                            <TableCell align="left">Address</TableCell>
                            <TableCell align="left">Flight Info</TableCell>
                            <TableCell align="left">Provision Amount</TableCell>
                            <TableCell align="left">Card Details</TableCell>
                            <TableCell align="left">Provision Date</TableCell>
                          </TableRow>
                        </TableHead>
                        <TableBody>
                          {usersUsed.map((d) => (
                            <TableRow
                              key={d.passengerName}
                              sx={{
                                "&:last-child td, &:last-child th": {
                                  border: 0,
                                },
                              }}
                            >
                              <TableCell align="left">{d.passengerPID}</TableCell>
                              <TableCell align="left">{d.passengerName}</TableCell>
                              <TableCell align="left">{d.passengerSurname}</TableCell>
                              <TableCell align="left">{d.passengerEmail}</TableCell>
                              <TableCell align="left">{d.passengerPhoneNumber}</TableCell>
                              <TableCell align="left">{d.passengerAddress}</TableCell>
                              <TableCell align="left">{d.flightNo}</TableCell>
                              <TableCell align="left">{d.amount}</TableCell>
                              <TableCell align="left">{d.hiddenCardNo}</TableCell>
                              <TableCell align="left">{d.provisionDate}</TableCell>
                              
                            </TableRow>
                          ))}
                        </TableBody>
                      </Table>
                    </TableContainer>
                  )}
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

export default MyProvisionsPage;
