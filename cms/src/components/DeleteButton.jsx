import * as React from 'react';
import Button from '@mui/material/Button';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import IconButton from '@mui/material/IconButton';
import DeleteIcon from '@mui/icons-material/Delete';
import { Tooltip } from '@mui/material';
import useQuestionsOperations from '../hooks/useQuestionOperations';

export default function DeleteButton(qid) {
  const [open, setOpen] = React.useState(false);
  const { deleteQuestion } = useQuestionsOperations(); 

  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const handleConfirm = async () => {
    await deleteQuestion('https://tspr.ovh/api/company/questions/delete', {
      qid: qid.qid
    });

    setOpen(false)
  }

  return (
    <React.Fragment>
        <Tooltip title={'Elimina'} placement='top'>
            <IconButton aria-label="delete" sx={{color: '#c50404'}} onClick={handleClickOpen}>
                <DeleteIcon/>
            </IconButton>
        </Tooltip>
      <Dialog
        open={open}
        onClose={handleClose}
        aria-labelledby="alert-dialog-title"
        aria-describedby="alert-dialog-description"
      >
        <DialogContent>
          <DialogContentText id="alert-dialog-description">
            Sei sicuro di voler eliminare la card?
          </DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button  onClick={handleConfirm}>Si</Button>
          <Button  sx={{color: 'red'}} onClick={handleClose} autoFocus>No</Button>
        </DialogActions>
      </Dialog>
    </React.Fragment>
  );
}
