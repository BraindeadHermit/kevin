import Button from "@mui/material/Button";
import CssBaseline from "@mui/material/CssBaseline";
import TextField from "@mui/material/TextField";
import Box from "@mui/material/Box";
import Typography from "@mui/material/Typography";
import Container from "@mui/material/Container";
import { alpha, createTheme, ThemeProvider } from "@mui/material/styles";
import { useAuth } from "../../hooks/useAuth";

const defaultTheme = createTheme({
  palette: {
    background: {
      default: "#009688;",
    },
    primary: {
      main: "#CD2222",
    },
    secondary: {
      main: alpha("#FFFFFF", 0.7),
    },
  },
  components: {
    MuiInputBase: {
      styleOverrides: {
        root: {
          borderRadius: "20px",
          background: "#009688",
        },
      },
    },
    MuiOutlinedInput: {
      styleOverrides: {
        root: {
          color: "white",
          borderRadius: "20px",
        },
      },
    },
    MuiCheckbox: {
      styleOverrides: {
        root: {
          color: "white",
        },
      },
    },
  },
});

const LogIn = () => {
  const { login } = useAuth();

  return (
    <ThemeProvider theme={defaultTheme}>
      <Container component="main" maxWidth="sm" sx={{ color: "white" }}>
        <CssBaseline />
        <Box
          sx={{
            marginTop: 30,
            display: "flex",
            flexDirection: "column",
            alignItems: "center",
            borderRadius: 4,
            backgroundColor: "#00695F",
            padding: "30px",
          }}
        >
          <Typography component="h2" variant="h5">
            Sign in
          </Typography>
          <Box
            component="form"
            onSubmit={ async (e) => {
              e.preventDefault();
              const data = new FormData(e.currentTarget);
              await login("/api/company/auth/login", {
                login: data.get("login"),
                password: data.get("password"),
              });
            }}
            noValidate
            sx={{ mt: 1 }}
          >
            <TextField
              margin="normal"
              color="secondary"
              required
              fullWidth
              id="login"
              label="Email Address"
              name="login"
              autoComplete="email"
              autoFocus
            />
            <TextField
              margin="normal"
              color="secondary"
              required
              fullWidth
              name="password"
              label="Password"
              type="password"
              id="password"
              autoComplete="current-password"
            />
            <Button
              color="primary"
              type="submit"
              fullWidth
              variant="contained"
              sx={{ mt: 3, mb: 2, borderRadius: 15, padding: "10px 18px" }}
            >
              Accedi
            </Button>
          </Box>
        </Box>
      </Container>
    </ThemeProvider>
  );
};

export default LogIn;
