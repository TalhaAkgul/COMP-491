import React, { useState, useEffect } from 'react';
import axios from 'axios';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';

function ProvisionUsed() {
  const [data, setData] = useState([]);
  const [searchQuery, setSearchQuery] = useState('');

  useEffect(() => {
    axios.get('/api/data').then((response) => {
      setData(response.data);
    });
  }, []);

  const filteredData = data.filter((item) =>
    item.name.toLowerCase().includes(searchQuery.toLowerCase())
  );

  const myData = [
    { id: 1, name: 'Pinar', surname: 'Erbil', provisionAmount: 28, paymentDetails: 'Ankara', flightNo: 'TK1234' },
    { id: 2, name: 'Betul', surname: 'Demirtas', provisionAmount: 35, paymentDetails: 'Izmir', flightNo: 'TK123' },
    { id: 3, name: 'Talha', surname: 'Akgul', provisionAmount: 42, paymentDetails: 'Istanbul', flightNo: 'TK12344' },
    { id: 4, name: 'Doga Ege', surname: 'Inhanli', provisionAmount: 25, paymentDetails: 'Balikesi', flightNo: 'TK124434' }
  ]

  return (
    <div>
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
          {myData.map((d) => (
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
   </div>
  );
}

export default ProvisionUsed;
