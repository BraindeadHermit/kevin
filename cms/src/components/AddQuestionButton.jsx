import * as React from 'react';
import Button from '@mui/material/Button';
import { styled } from '@mui/material/styles';
import Dialog from '@mui/material/Dialog';
import DialogTitle from '@mui/material/DialogTitle';
import DialogContent from '@mui/material/DialogContent';
import DialogActions from '@mui/material/DialogActions';
import IconButton from '@mui/material/IconButton';
import CloseIcon from '@mui/icons-material/Close';
import Typography from '@mui/material/Typography';
import { Box, Divider, InputBase } from '@mui/material';

const BootstrapDialog = styled(Dialog)(({ theme }) => ({
  '& .MuiDialogContent-root': {
    padding: theme.spacing(2),
  },
  '& .MuiDialogActions-root': {
    padding: theme.spacing(1),
  },
}));

export default function AddQuestionButton() {
  const [open, setOpen] = React.useState(false);
  const [flag, setFlag] = React.useState(true)

  const handleTextChange = (event) => {
    if (event.target.value != '')
      setFlag(false)
    else
      setFlag(true)
  };

  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const handleChanges = (event) => {
    handleClose();
  };

  return (
    <React.Fragment>
      <Button variant='contained' disableElevation size='large' sx={{borderRadius: 14, backgroundColor: '#05ad05'}} onClick={handleClickOpen}>
        Aggiungi Domanda
      </Button>
      <BootstrapDialog
        fullWidth='500px'
        onClose={handleClose}
        aria-labelledby="customized-dialog-title"
        open={open}
      >
        <DialogTitle sx={{ m: 0, p: 2 }} id="customized-dialog-title">
          <Typography variant='subtitle2' padding={0.5} fontWeight={800}>
              Domanda
          </Typography>    
          <InputBase onChange={handleTextChange} sx={{ ml: 1, flex: 1, padding: 1 }}/>  
        </DialogTitle>
        <IconButton
          aria-label="close"
          onClick={handleClose}
          sx={{
            position: 'absolute',
            right: 8,
            top: 8,
            color: (theme) => theme.palette.grey[500],
          }}
        >
          <CloseIcon />
        </IconButton>
        <DialogContent dividers>
          <Box>
            <Typography variant='subtitle2' padding={0.5} fontWeight={800}>
                Risposte
            </Typography>
            <Box display={'flex'} flexDirection={'column'} sx={{ border: '0.1px solid', borderRadius: 4, borderColor:'rgba(0, 0, 0, 0.12)' }}>
                <InputBase onChange={handleTextChange} sx={{ ml: 1, flex: 1, padding: 1 }}/>
                <Divider/>
                <InputBase onChange={handleTextChange} sx={{ ml: 1, flex: 1, padding: 1 }}/>
                <Divider/>
                <InputBase onChange={handleTextChange} sx={{ ml: 1, flex: 1, padding: 1 }}/>
                <Divider/>
                <InputBase onChange={handleTextChange} sx={{ ml: 1, flex: 1, padding: 1 }}/>
            </Box>
          </Box>
        </DialogContent>
        <DialogActions>
          <Button disabled={flag} sx={{color: '#edc115'}} autoFocus onClick={handleChanges}>
            Aggiungi
          </Button>
        </DialogActions>
      </BootstrapDialog>
    </React.Fragment>
  );
}