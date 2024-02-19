import {
  Box,
  Divider,
  LinearProgress,
  Tooltip,
  Typography,
  styled,
} from "@mui/material";
import DeleteButton from "./DeleteButton";

const Progress = styled(LinearProgress)(({ theme }) => ({
  height: 20,
  borderRadius: 12,
}));

export default function QuestionCard(props) {

  return (
    <Box
      border={0.2}
      borderColor={"#616161"}
      sx={{ padding: 1.2, borderRadius: 8, width: "auto" }}
      key={props.question.QID}
    >
      <Box
        display="flex"
        justifyContent="space-between"
        alignItems="start"
        sx={{ padding: 1.5 }}
      >
        <Box sx={{ display: "flex", flexDirection: "column", maxWidth: "70%" }}>
          <Typography variant="subtitle1" fontWeight={800}>
            {props.question.Body}
          </Typography>
          <Typography color={"#616161"}>
            risposte totali: {props.questionTotal}
          </Typography>
        </Box>
        <Box>
          <DeleteButton qid={props.question.QID} />
        </Box>
      </Box>
      <Divider variant="middle" sx={{ borderWidth: 1, margin: 1 }} />
      {props.question &&
        props.question["Options"].map((option) => {

          return (
            <Box sx={{ display: "flex", flexDirection: "column" }}>
              <Progress
                variant="determinate"
                value={option[1] ? props.questionTrue : props.questionFalse}
                color={option[1] ? "success" : "error"}
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
                  risposte: {option[1] ? props.questionTrue : props.questionFalse}
                </Typography>
              </Box>
            </Box>
          );
        })}
    </Box>
  );
}
