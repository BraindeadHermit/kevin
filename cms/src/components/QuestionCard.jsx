import { Box, Button, Divider, LinearProgress, Typography, styled } from "@mui/material";

const Progress = styled(LinearProgress)(({ theme }) => ({
  height: 20,
  borderRadius: 12,
  [`&.${LinearProgress.colorPrimary}`]: {
    backgroundColor: 'green',
  },
  [`& .${LinearProgress.bar}`]: {
    backgroundColor: theme.palette.error.main,
  },
}));

export default function QuestionCard() {
  return (
  <Box border={0.2} borderColor={'#616161'} sx={{padding: 1, borderRadius: 8, width: 'auto'}}>
    <Box display="flex" justifyContent="space-between" alignItems="start" sx={{padding: 1.5}}>
      <Box sx={{display: 'flex', flexDirection: 'column', maxWidth: '70%'}}>
        <Typography variant="subtitle1" fontWeight={800}>Quale tipo di protocollo viene utilizzato per effettuare una richiesta al server?</Typography>
        <Typography color={'#616161'}>risposte totali: 36</Typography>
      </Box>
      <Button variant="contained" disableElevation>Edit Question</Button>
    </Box>
    <Divider variant="middle" sx={{borderWidth: 1, margin: 1}}></Divider>
    <Box sx={{display: 'flex', flexDirection: 'column', padding: 1}}>
      <Progress variant="determinate" value={35}></Progress>
      <Typography variant="subtitle2" sx={{paddingTop: 1, paddingBottom: 1}} color={'#616161'}>risposte totali: 2</Typography>
      <Progress variant="determinate" value={20}></Progress>
      <Typography variant="subtitle2" sx={{paddingTop: 1, paddingBottom: 1}} color={'#616161'}>risposte totali: 10</Typography>
      <Progress variant="determinate" value={30}></Progress>
      <Typography variant="subtitle2" sx={{paddingTop: 1, paddingBottom: 1}} color={'#616161'}>risposte totali: 16</Typography>
      <Progress variant="determinate" value={12}></Progress>
      <Typography variant="subtitle2" sx={{paddingTop: 1, paddingBottom: 1}} color={'#616161'}>risposte totali: 8</Typography>
    </Box>
  </Box>
  )
}
