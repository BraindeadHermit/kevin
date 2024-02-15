import React, { useState } from 'react';
import { Button, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, TextField, Radio, RadioGroup, FormControlLabel, FormControl, FormLabel } from '@mui/material';
import useQuestionsOperations from '../hooks/useQuestionOperations';

const FormDialog = ({category}) => {
  const [open, setOpen] = useState(false);
  const [question, setQuestion] = useState('');
  const [answers, setAnswers] = useState([['', false], ['', false], ['', false], ['', false]]);
  const [correctAnswer, setCorrectAnswer] = useState('');
  const { insert } = useQuestionsOperations();

  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const handleInputChange = (index, event) => {
    const updatedAnswers = [...answers];
    updatedAnswers[index][0] = event.target.value;

    updatedAnswers.forEach(element => {
      if (element[0] == correctAnswer)
        element[1] = true;
    })

    setAnswers(updatedAnswers);
  };

  const handleRadioChange = (e) => {
    setCorrectAnswer(e.value.value);
  };

  const handleSubmit = async () => {

    await insert('api/company/questions/add', {
      body: question,
      options: answers,
      category: category,
      inUse: true
    });



    handleClose();
  };

  return (
    <div>
      <Button variant='contained' disableElevation size='large' sx={{borderRadius: 14, backgroundColor: '#05ad05'}} onClick={handleClickOpen}>
        Aggiungi Domanda
      </Button>
      <Dialog open={open} onClose={handleClose} aria-labelledby="form-dialog-title">
        <DialogTitle id="form-dialog-title">Inserisci una nuova domanda</DialogTitle>
        <DialogContent>
          <DialogContentText>
            Inserisci la domanda e le risposte. Seleziona la risposta corretta.
          </DialogContentText>
          <TextField
            autoFocus
            margin="dense"
            id="question"
            label="Domanda"
            type="text"
            fullWidth
            value={question}
            onChange={(e) => setQuestion(e.target.value)}
          />
          <FormControl component="fieldset">
            <FormLabel component="legend">Risposte</FormLabel>
            <RadioGroup value={correctAnswer} onChange={handleRadioChange}>
              {answers.map((answer, index) => (
                <FormControlLabel
                  key={index}
                  value={index.toString()}
                  control={<Radio />}
                  label={
                    <TextField
                      margin="dense"
                      id={`answer-${index}`}
                      label={`Risposta ${index + 1}`}
                      type="text"
                      fullWidth
                      value={answer[0]}
                      variant='standard'
                      onChange={(e) => handleInputChange(index, e)}
                    />
                  }
                />
              ))}
            </RadioGroup>
          </FormControl>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose} sx={{color: 'red'}}>
            Annulla
          </Button>
          <Button onClick={handleSubmit} color="primary">
            Invia
          </Button>
        </DialogActions>
      </Dialog>
    </div>
  );
};

export default FormDialog;
