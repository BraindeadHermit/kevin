import { Box, Divider, LinearProgress, Tooltip, Typography, styled } from "@mui/material";
import ModalEditQuestion from "./ModalEditQuestion";

const Progress = styled(LinearProgress)(({ theme }) => ({
  height: 20,
  borderRadius: 12,
}));

export default function QuestionCard() {
  return (
  <Box border={0.2} borderColor={'#616161'} sx={{padding: 1.2, borderRadius: 8, width: 'auto'}}>
    <Box display="flex" justifyContent="space-between" alignItems="start" sx={{padding: 1.5}}>
      <Box sx={{display: 'flex', flexDirection: 'column', maxWidth: '70%'}}>
        <Typography variant="subtitle1" fontWeight={800}>Quale tipo di protocollo viene utilizzato per effettuare una richiesta al server?</Typography>
        <Typography color={'#616161'}>risposte totali: 36</Typography>
      </Box>
      <ModalEditQuestion/>
    </Box>
    <Divider variant="middle" sx={{borderWidth: 1, margin: 1}}></Divider>
    <Box sx={{display: 'flex', flexDirection: 'column'}}>
      <Progress variant="determinate" value={35}></Progress>
      <Box sx={{display: 'flex', flexDirection: 'row', padding: 1, justifyContent: 'space-between'}}> 
        <Box maxWidth={'40%'}>
          <Tooltip title={'UDP'} placement="bottom-start">
            <Typography noWrap={true} variant="subtitle2" fontWeight={900} color={'#616161'}>UDP</Typography>
          </Tooltip>
        </Box>
        <Typography variant="subtitle2" color={'#616161'}>risposte totali: 2</Typography>
      </Box>
    </Box>
    <Box sx={{display: 'flex', flexDirection: 'column'}}>
      <Progress variant="determinate" value={35} sx={{color: (correttezza) => (correttezza === 'si' ? 'green' : 'red')}}></Progress>
      <Box sx={{display: 'flex', flexDirection: 'row', padding: 1, justifyContent: 'space-between'}}> 
        <Box maxWidth={'40%'}>
          <Tooltip title={'UDP'} placement="bottom-start">
            <Typography noWrap={true} variant="subtitle2" fontWeight={900} color={'#616161'}>UDP</Typography>
          </Tooltip>
        </Box>
        <Typography variant="subtitle2" color={'#616161'}>risposte totali: 2</Typography>
      </Box>
    </Box>
    <Box sx={{display: 'flex', flexDirection: 'column'}}>
      <Progress variant="determinate" value={35}></Progress>
      <Box sx={{display: 'flex', flexDirection: 'row', padding: 1, justifyContent: 'space-between'}}> 
        <Box maxWidth={'40%'}>
          <Tooltip title={'UDP'} placement="bottom-start">
            <Typography noWrap={true} variant="subtitle2" fontWeight={900} color={'#616161'}>UDP</Typography>
          </Tooltip>
        </Box>
        <Typography variant="subtitle2" color={'#616161'}>risposte totali: 2</Typography>
      </Box>
    </Box>
    <Box sx={{display: 'flex', flexDirection: 'column'}}>
      <Progress variant="determinate" value={35}></Progress>
      <Box sx={{display: 'flex', flexDirection: 'row', padding: 1, justifyContent: 'space-between'}}> 
        <Box maxWidth={'40%'}>
          <Tooltip title={'UDP'} placement="bottom-start">
            <Typography noWrap={true} variant="subtitle2" fontWeight={900} color={'#616161'}>UDP</Typography>
          </Tooltip>
        </Box>
        <Typography variant="subtitle2" color={'#616161'}>risposte totali: 2</Typography>
      </Box>
    </Box>
  </Box>
  )
}
