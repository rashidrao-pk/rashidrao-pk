#ifndef __hdlcoder_medianimagefilter_sfun_h__
#define __hdlcoder_medianimagefilter_sfun_h__

/* Include files */
#define S_FUNCTION_NAME                sf_sfun
#include "covrt.h"
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/MessageServiceLayer.h"
#include "sf_runtime/DebuggerRuntimeInterface.h"
#include "sf_runtime/sfc_mex.h"
#include "sf_runtime/sf_runtime_errors.h"
#include "rtwtypes.h"
#include "simtarget/slSimTgtClientServerAPIBridge.h"
#include "sf_runtime/sfc_sdi.h"
#include "sf_runtime/sf_test_language.h"
#include "multiword_types.h"
#include "sf_runtime/sfc_messages.h"
#include "sf_runtime/sfcdebug.h"
#define rtInf                          (mxGetInf())
#define rtMinusInf                     (-(mxGetInf()))
#define rtNaN                          (mxGetNaN())
#define rtIsNaN(X)                     ((int)mxIsNaN(X))
#define rtIsInf(X)                     ((int)mxIsInf(X))

struct SfDebugInstanceStruct;
extern struct SfDebugInstanceStruct* sfGlobalDebugInstanceStruct;

/* Auxiliary Header Files */
#include "libmwimfilter.h"
#include "libmwippfilter.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */
extern uint32_T _hdlcoder_medianimagefilterMachineNumber_;

/* Variable Definitions */

/* Function Declarations */
extern void hdlcoder_medianimagefilter_initializer(void);
extern void hdlcoder_medianimagefilter_terminator(void);

/* Function Definitions */

/* We load infoStruct for rtw_optimation_info on demand in mdlSetWorkWidths and
   free it immediately in mdlStart. Given that this is machine-wide as
   opposed to chart specific, we use NULL check to make sure it gets loaded
   and unloaded once per machine even though the  methods mdlSetWorkWidths/mdlStart
   are chart/instance specific. The following methods abstract this out. */
extern mxArray* load_hdlcoder_medianimagefilter_optimization_info(boolean_T
  isRtwGen, boolean_T isModelRef, boolean_T isExternal);
extern void unload_hdlcoder_medianimagefilter_optimization_info(void);

#endif
