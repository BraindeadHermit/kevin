import * as React from 'react';
import { styled, createTheme, ThemeProvider } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
import MuiDrawer from '@mui/material/Drawer';
import Box from '@mui/material/Box';
import Grid from '@mui/material/Grid';
import MuiAppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import List from '@mui/material/List';
import { Divider, ListItemButton } from '@mui/material';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Typography from '@mui/material/Typography';
import IconButton from '@mui/material/IconButton';
import Container from '@mui/material/Container';
import MenuIcon from '@mui/icons-material/Menu';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import DashboardIcon from '@mui/icons-material/Dashboard';
import SportsEsportsIcon from '@mui/icons-material/SportsEsports';
import VideogameAssetIcon from '@mui/icons-material/VideogameAsset';
import AccountMenu from '../../components/AccountMenu';
import BarChart from '../../components/BarChart';
import QuestionCard from '../../components/QuestionCard';

const drawerWidth = 240;

const AppBar = styled(MuiAppBar, {
  shouldForwardProp: (prop) => prop !== 'open',
})(({ theme, open }) => ({
  zIndex: theme.zIndex.drawer + 1,
  transition: theme.transitions.create(['width', 'margin'], {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  ...(open && {
    marginLeft: drawerWidth,
    width: `calc(100% - ${drawerWidth}px)`,
    transition: theme.transitions.create(['width', 'margin'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  }),
}));

const Drawer = styled(MuiDrawer, { shouldForwardProp: (prop) => prop !== 'open' })(
  ({ theme, open }) => ({
    '& .MuiDrawer-paper': {
      position: 'relative',
      whiteSpace: 'nowrap',
      width: drawerWidth,
      transition: theme.transitions.create('width', {
        easing: theme.transitions.easing.sharp,
        duration: theme.transitions.duration.enteringScreen,
      }),
      boxSizing: 'border-box',
      ...(!open && {
        overflowX: 'hidden',
        transition: theme.transitions.create('width', {
          easing: theme.transitions.easing.sharp,
          duration: theme.transitions.duration.leavingScreen,
        }),
        width: theme.spacing(7),
        [theme.breakpoints.up('sm')]: {
          width: theme.spacing(9),
        },
      }),
    },
  }),
);

const defaultTheme = createTheme();

export default function Dashboard() {
  const [open, setOpen] = React.useState(true);
  const toggleDrawer = () => {
    setOpen(!open);
  };

  const [selectedIndex, setSelectedIndex] = React.useState(1);

  const handleListItemClick = (event, index) => {
    setSelectedIndex(index);
  };

  return (
    <ThemeProvider theme={defaultTheme}>
      <Box sx={{ display: 'flex' }}>
        <CssBaseline />
        <AppBar position="absolute" open={open} sx={{background: '#009688'}}>
          <Toolbar
            sx={{
              pr: '24px', // keep right padding when drawer closed
            }}
          >
            <IconButton
              edge="start"
              color="inherit"
              aria-label="open drawer"
              onClick={toggleDrawer}
              sx={{
                marginRight: '36px',
                ...(open && { display: 'none' }),
              }}
            >
              <MenuIcon />
            </IconButton>
            <Typography
              component="h1"
              variant="h6"
              color="inherit"
              noWrap
              sx={{ flexGrow: 1 }}
            >
              Kevin - Backoffice
            </Typography>
            <AccountMenu/>
          </Toolbar>
        </AppBar>
        <Drawer variant="permanent" open={open}>
          <Toolbar
            sx={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'flex-end',
              px: [1],
            }}
          >
            <IconButton onClick={toggleDrawer}>
              <ChevronLeftIcon />
            </IconButton>
          </Toolbar>
          <List component="nav">
            <ListItemButton selected={selectedIndex === 0} onClick={(event) => handleListItemClick(event, 0)}            
             style={{backgroundColor: selectedIndex === 0 ? '#009688' : 'transparent', borderTopRightRadius: '24px', 
             borderBottomRightRadius: '24px', marginRight: '15px'}}>
              <ListItemIcon>
                <DashboardIcon style={{color: selectedIndex === 0 ? 'white' : ''}}/>
              </ListItemIcon>
              <ListItemText primary="Dashboard" style={{color: selectedIndex === 0 ? 'white' : ''}}/>
            </ListItemButton>
            <ListItemButton selected={selectedIndex === 1} onClick={(event) => handleListItemClick(event, 1)}          
             style={{backgroundColor: selectedIndex === 1 ? '#009688' : 'transparent', borderTopRightRadius: '24px', 
             borderBottomRightRadius: '24px', marginRight: '15px' }}>
              <ListItemIcon>
                <SportsEsportsIcon style={{color: selectedIndex === 1 ? 'white' : ''}}/>
              </ListItemIcon>
              <ListItemText primary="Livello 1" style={{color: selectedIndex === 1 ? 'white' : ''}}/>
            </ListItemButton>
            <ListItemButton selected={selectedIndex === 2} onClick={(event) => handleListItemClick(event, 2)} 
             style={{backgroundColor: selectedIndex === 2 ? '#009688' : 'transparent', borderTopRightRadius: '24px', 
             borderBottomRightRadius: '24px', marginRight: '15px'}}>
              <ListItemIcon>
                <VideogameAssetIcon style={{color: selectedIndex === 2 ? 'white' : ''}}/>
              </ListItemIcon>
              <ListItemText primary="Livello 2" style={{color: selectedIndex === 2 ? 'white' : ''}} />
            </ListItemButton>
          </List>
        </Drawer>
        <Box
          component="main"
          sx={{
            backgroundColor: (theme) =>
              theme.palette.mode === 'light'
                ? theme.palette.grey[100]
                : theme.palette.grey[900],
            flexGrow: 1,
            height: '100vh',
            overflow: 'auto',
          }}
        >
          <Toolbar />
          <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
            <Box style={{margin: 'auto', width: '80%', height: '40vh'}}>
              <BarChart/>
            </Box>
            <Box>
              <Box sx={{marginBottom: 5, marginTop: 2}}>
                <Typography variant='h6' fontWeight={900}>LIVELLO 1</Typography>
                <Divider style={{stroke: 3}}  sx={{ borderWidth: 1, borderColor: '#616161'}}/>
              </Box>
              <Grid container rowSpacing={4} columnSpacing={{ xs: 1, sm: 2, md: 3 }}>
                <Grid item xs={6}>
                  <QuestionCard/>
                </Grid>
                <Grid item xs={6}>
                  <QuestionCard/>
                </Grid>
                <Grid item xs={6}>
                  <QuestionCard/>
                </Grid>
              </Grid>
            </Box>
            <Box>
              <Box sx={{marginBottom: 5, marginTop: 2}}>
                <Typography variant='h6' fontWeight={900}>LIVELLO 2</Typography>
                <Divider style={{marginBottom: 20, stroke: 3}}  sx={{ borderWidth: 1, borderColor: '#616161'}}/>
              </Box>
              <Grid container rowSpacing={4} columnSpacing={{ xs: 1, sm: 2, md: 3 }}>
                <Grid item xs={6}>
                  <QuestionCard/>
                </Grid>
                <Grid item xs={6}>
                  <QuestionCard/>
                </Grid>
                <Grid item xs={6}>
                  <QuestionCard/>
                </Grid>
                <Grid item xs={6}>
                  <QuestionCard/>
                </Grid>
              </Grid>
            </Box>
          </Container>
        </Box>
      </Box>
    </ThemeProvider>
  );
}