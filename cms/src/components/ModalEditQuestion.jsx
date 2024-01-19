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

export default function ModalEditQuestion() {
  const [open, setOpen] = React.useState(false);
  const [defaultValue, setDefaultValue] = React.useState('UDP')

  const handleClickOpen = () => {
    setOpen(true);
  };
  const handleClose = () => {
    setOpen(false);
  };
  const handleChanges = (event) => {
    setDefaultValue(event.target.value);
  };
  const handleSaveChanges = () => {
    handleClose();
  }

  return (
    <React.Fragment>
      <Button variant="outlined" onClick={handleClickOpen}>
        Edit Question
      </Button>
      <BootstrapDialog
        onClose={handleClose}
        aria-labelledby="customized-dialog-title"
        open={open}
      >
        <DialogTitle sx={{ m: 0, p: 2 }} id="customized-dialog-title">
             Quale tipo di protocollo viene utilizzato per effettuare una richiesta al server?
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
                <InputBase sx={{ ml: 1, flex: 1, padding: 1 }} onChange={handleChanges} defaultValue={defaultValue}/>
                <Divider/>
                <InputBase sx={{ ml: 1, flex: 1, padding: 1 }} onChange={handleChanges} defaultValue={defaultValue}/>
                <Divider/>
                <InputBase sx={{ ml: 1, flex: 1, padding: 1 }} onChange={handleChanges} defaultValue={defaultValue}/>
                <Divider/>
                <InputBase sx={{ ml: 1, flex: 1, padding: 1 }} onChange={handleChanges} defaultValue={defaultValue}/>
            </Box>
          </Box>
        </DialogContent>
        <DialogActions>
          <Button autoFocus onClick={handleSaveChanges}>
            Save changes
          </Button>
        </DialogActions>
      </BootstrapDialog>
    </React.Fragment>
  );
}