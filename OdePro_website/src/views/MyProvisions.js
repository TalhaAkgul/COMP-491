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
import { useState, useEffect } from "react";
import axios from 'axios';

import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
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

  const [mydata, setMydata] = useState([]);
  const [activeTab, setActiveTab] = React.useState("1");
  var [search, setSearch] = useState('');
  var [name, setName] = useState('');
  var [surname, setSurname] = useState('');
  var [id, setId] = useState('');

  const data = [
    { id: "1", name: 'Pinar', surname: 'Erbil', provisionAmount: 28, paymentDetails: 'Ankara', flightNo: 'TK1234', condition: 'Used' },
    { id: "2", name: 'Pinarrr', surname: 'Erbil', provisionAmount: 28, paymentDetails: 'Ankara', flightNo: 'TK1234', condition: 'Active' },
    { id: "3", name: 'Betul', surname: 'Demirtas', provisionAmount: 35, paymentDetails: 'Izmir', flightNo: 'TK123', condition: 'Used'  },
    { id: "4", name: 'Talha', surname: 'Akgul', provisionAmount: 42, paymentDetails: 'Istanbul', flightNo: 'TK12344', condition: 'Used'  },
    { id: "5", name: 'Doga Ege', surname: 'Inhanli', provisionAmount: 25, paymentDetails: 'Balikesi', flightNo: 'TK124434', condition: 'Active' }
  ];

  useEffect(() => {
    axios.get('/api/data').then((response) => {
      setMydata(response.data);
    });
  }, []);
    
  const filteredDataUsed = data.filter((item) =>
    search &&
    item.condition.toLowerCase().includes('Used'.toLowerCase()) &&
    item.name.toLowerCase().includes(search.name.toLowerCase()) &&
    item.surname.toLowerCase().includes(search.surname.toLowerCase()) &&
    item.id.includes(search.id)
  );

  const filteredDataActive = data.filter((item) =>
    search && 
    item.condition.toLowerCase().includes('Active'.toLowerCase())  &&
    item.name.toLowerCase().includes(search.name.toLowerCase()) &&
    item.surname.toLowerCase().includes(search.surname.toLowerCase()) &&
    item.id.includes(search.id)

  );

  const toggle = (tab) => {
    if (activeTab !== tab) {
      setActiveTab(tab);
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    setSearch( { id: id, name: name, surname: surname});
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
              <FormGroup className="col-md-4">
                <Label for="inputName">Name</Label>
                <Input type="text" onChange={(e) => setName(e.target.value)} id="inputName" placeholder="Name"/>
              </FormGroup>
              <FormGroup className="col-sm-4">
                <Label for="inputSurname">Surname</Label>
                <Input type="text" onChange={(e) =>  setSurname(e.target.textContent)} id="inputSurname" placeholder="Surname"/>
              </FormGroup>
              <FormGroup className="col-md-4">
                <Label>Identity Number</Label>
                <Input type="text" onChange={(e) => setId(e.target.value)} id="inputID" placeholder="Identity Number"/>
              </FormGroup>
            </div>
            <Button className="btn-round"  type="submit" color="info">
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
                { (!search || !filteredDataActive[0]) && <CardText>You don't have any active provisions</CardText> }
                  {search && filteredDataActive[0] && (
                    <TableContainer component={Paper}>
                    <Table sx={{ minWidth: 650 }} aria-label="simple table">
                      <TableHead>
                        <TableRow>
                          <TableCell>ID Number</TableCell>
                          <TableCell align="left">Name</TableCell>
                          <TableCell align="left">Surname</TableCell>
                          <TableCell align="left">Provision Amount</TableCell>
                          <TableCell align="left">Payment Details</TableCell>
                          <TableCell align="left">Flight Number</TableCell>
                        </TableRow>
                      </TableHead>
                      <TableBody>
                        {filteredDataActive.map((d) => (
                          <TableRow
                            key={d.name}
                            sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
                          >
                            <TableCell component="th" scope="row">
                              {d.id}
                            </TableCell>
                            <TableCell align="left">{d.name}</TableCell>
                            <TableCell align="left">{d.surname}</TableCell>
                            <TableCell align="left">{d.provisionAmount}</TableCell>
                            <TableCell align="left">{d.paymentDetails}</TableCell>
                            <TableCell align="left">{d.flightNo}</TableCell>
                          </TableRow>
                        ))}
                      </TableBody>
                    </Table>
                  </TableContainer>
                  )}
                </TabPane>
                <TabPane tabId="2">
                  { (!search || !filteredDataUsed[0]) && <CardText>You don't have any used provisions</CardText> }
                  {search && filteredDataUsed[0] && (
                    <TableContainer component={Paper}>
                    <Table sx={{ minWidth: 650 }} aria-label="simple table">
                      <TableHead>
                        <TableRow>
                          <TableCell>ID Number</TableCell>
                          <TableCell align="left">Name</TableCell>
                          <TableCell align="left">Surname</TableCell>
                          <TableCell align="left">Provision Amount</TableCell>
                          <TableCell align="left">Payment Details</TableCell>
                          <TableCell align="left">Flight Number</TableCell>
                        </TableRow>
                      </TableHead>
                      <TableBody>
                        {filteredDataUsed.map((d) => (
                          <TableRow
                            key={d.name}
                            sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
                          >
                            <TableCell component="th" scope="row">
                              {d.id}
                            </TableCell>
                            <TableCell align="left">{d.name}</TableCell>
                            <TableCell align="left">{d.surname}</TableCell>
                            <TableCell align="left">{d.provisionAmount}</TableCell>
                            <TableCell align="left">{d.paymentDetails}</TableCell>
                            <TableCell align="left">{d.flightNo}</TableCell>
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

export default ProfilePage;
