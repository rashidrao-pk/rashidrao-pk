#ifndef __c2_hdlcoder_medianimagefilter_h__
#define __c2_hdlcoder_medianimagefilter_h__

/* Type Definitions */
#ifndef typedef_SFc2_hdlcoder_medianimagefilterInstanceStruct
#define typedef_SFc2_hdlcoder_medianimagefilterInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c2_sfEvent;
  boolean_T c2_doneDoubleBufferReInit;
  uint8_T c2_is_active_c2_hdlcoder_medianimagefilter;
  uint8_T c2_ImageIn[76800];
  uint8_T c2_ImageBlur[76800];
  uint8_T c2_ImageOut[76800];
  uint8_T c2_b_ImageIn[76800];
  uint8_T c2_uv1[76800];
  uint8_T c2_uv2[76800];
  uint8_T c2_a[77924];
  uint8_T c2_varargin_1[76800];
  void *c2_fEmlrtCtx;
  uint8_T (*c2_c_ImageIn)[76800];
  uint8_T (*c2_b_ImageOut)[76800];
  real_T *c2_density;
} SFc2_hdlcoder_medianimagefilterInstanceStruct;

#endif                                 /*typedef_SFc2_hdlcoder_medianimagefilterInstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c2_hdlcoder_medianimagefilter_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c2_hdlcoder_medianimagefilter_get_check_sum(mxArray *plhs[]);
extern void c2_hdlcoder_medianimagefilter_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
