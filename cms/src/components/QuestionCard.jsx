import {
  Box,
  Divider,
  LinearProgress,
  Tooltip,
  Typography,
  styled,
} from "@mui/material";
import ModalEditQuestion from "./ModalEditQuestion";
import DeleteButton from "./DeleteButton";

const Progress = styled(LinearProgress)(({ theme }) => ({
  height: 20,
  borderRadius: 12,
}));

export default function QuestionCard(question) {

  return (
    <Box 
      border={0.2}
      borderColor={"#616161"}
      sx={{ padding: 1.2, borderRadius: 8, width: "auto" }}
      key={question.question.QID}
    >
      <Box
        display="flex"
        justifyContent="space-between"
        alignItems="start"
        sx={{ padding: 1.5 }}
      >
        <Box sx={{ display: "flex", flexDirection: "column", maxWidth: "70%" }}>
          <Typography variant="subtitle1" fontWeight={800}>
            {question.question.Body}
          </Typography>
          <Typography color={"#616161"}>
            risposte totali: {}
          </Typography>
        </Box>
        <Box>
          <ModalEditQuestion question={question}/>
          <DeleteButton qid={question.question.QID} />
        </Box>
      </Box>
      <Divider variant="middle" sx={{ borderWidth: 1, margin: 1 }}></Divider>
      {question &&
        question.question["Options"].map((option) => {
          const randomValue = Math.floor(Math.random() * (20 + 1));

        return (
          <Box sx={{ display: "flex", flexDirection: "column" }}>
            <Progress 
              variant="determinate" 
              value={randomValue} 
              color={option[1] ? 'success' : 'error'}
            />
            <Box
              sx={{
                display: "flex",
                flexDirection: "row",
                padding: 1,
                justifyContent: "space-between",
              }}
            >
              <Box maxWidth={"40%"}>
                <Tooltip title={option} placement="bottom-start">
                  <Typography
                    noWrap={true}
                    variant="subtitle2"
                    fontWeight={900}
                    color={"#616161"}
                  >
                    {option}
                  </Typography>
                </Tooltip>
              </Box>
              <Typography variant="subtitle2" color={"#616161"}>
                risposte: {randomValue}
              </Typography>
            </Box>
          </Box>
        );
      })}
    </Box>
  );
}
