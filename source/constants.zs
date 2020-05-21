
// Constants
const I_FLAGS = 0;
const I_MAG   = 1;
const I_AUTO  = 2;
const I_ZOOM  = 3;
const I_HEAT  = 4;
CONST I_BORE  = 6;

CONST I_BARREL = 29;
CONST I_MISC   = 30;
CONST I_SCOPE  = 31;

const F_CHAMBER        = 1;
const F_CHAMBER_BROKE  = 2;
const F_NO_FIRE_SELECT = 32;
const F_UNLOAD_ONLY    = 128;


const ENC_556MAG = 17;
const ENC_556MAG_EMPTY = ENC_556MAG * 0.4;
const ENC_556_LOADED = (ENC_556MAG * 0.6) / 50.;
const ENC_556 = ENC_556_LOADED * 1.4;
const ENC_556MAG_LOADED = ENC_556MAG_EMPTY * 0.4;

const ENC_762MAG = 19;
const ENC_762MAG_EMPTY = ENC_762MAG * 0.4;
const ENC_762_LOADED = (ENC_762MAG * 0.6) / 50.;
const ENC_762 = ENC_762_LOADED * 1.4;
const ENC_762MAG_LOADED = ENC_762MAG_EMPTY * 0.4;

const HDLD_556MAG = "556";
const HDLD_762MAG = "762";
