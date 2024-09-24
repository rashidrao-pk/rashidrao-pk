/* Include files */

#include "hdlcoder_medianimagefilter_sfun.h"
#include "c2_hdlcoder_medianimagefilter.h"
#include "mwmathutil.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "hdlcoder_medianimagefilter_sfun_debug_macros.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c(S);

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization);
static void chart_debug_initialize_data_addresses(SimStruct *S);
static const mxArray* sf_opaque_get_hover_data_for_msg(void *chartInstance,
  int32_T msgSSID);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */
static real_T _sfTime_;
static const char * c2_debug_family_names[7] = { "coeff", "ImageBlur", "nargin",
  "nargout", "ImageIn", "density", "ImageOut" };

/* Function Declarations */
static void initialize_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance);
static void initialize_params_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance);
static void enable_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance);
static void disable_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance);
static void c2_update_debugger_state_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance);
static void set_sim_state_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance, const mxArray
   *c2_st);
static void finalize_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance);
static void sf_gateway_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance);
static void mdl_start_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance);
static void c2_chartstep_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance);
static void initSimStructsc2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber, uint32_T c2_instanceNumber);
static const mxArray *c2_sf_marshallOut(void *chartInstanceVoid, void *c2_inData);
static const mxArray *c2_b_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static void c2_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_c_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static real_T c2_emlrt_marshallIn(SFc2_hdlcoder_medianimagefilterInstanceStruct *
  chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static void c2_imfilter(SFc2_hdlcoder_medianimagefilterInstanceStruct
  *chartInstance, uint8_T c2_b_varargin_1[76800], uint8_T c2_b[76800]);
static void c2_padImage(SFc2_hdlcoder_medianimagefilterInstanceStruct
  *chartInstance, uint8_T c2_a_tmp[76800], real_T c2_boundary_pos, int8_T
  c2_boundaryEnum, real_T c2_boundaryStr_pos, uint8_T c2_b_a[77924]);
static void c2_padarray(SFc2_hdlcoder_medianimagefilterInstanceStruct
  *chartInstance, uint8_T c2_b_varargin_1[76800], uint8_T c2_b[77924]);
static void c2_mod(SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance,
                   real_T c2_x[242], real_T c2_r[242]);
static void c2_b_mod(SFc2_hdlcoder_medianimagefilterInstanceStruct
                     *chartInstance, real_T c2_x[322], real_T c2_r[322]);
static void c2_b_padarray(SFc2_hdlcoder_medianimagefilterInstanceStruct
  *chartInstance, uint8_T c2_b_varargin_1[76800], uint8_T c2_b[77924]);
static void c2_c_mod(SFc2_hdlcoder_medianimagefilterInstanceStruct
                     *chartInstance, real_T c2_x[242], real_T c2_r[242]);
static void c2_d_mod(SFc2_hdlcoder_medianimagefilterInstanceStruct
                     *chartInstance, real_T c2_x[322], real_T c2_r[322]);
static const mxArray *c2_emlrt_marshallOut
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance, const uint8_T
   c2_u[76800]);
static const mxArray *c2_b_emlrt_marshallOut
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance, const char_T
   c2_u[13]);
static const mxArray *c2_c_emlrt_marshallOut
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance, const real_T
   c2_u);
static void c2_b_emlrt_marshallIn(SFc2_hdlcoder_medianimagefilterInstanceStruct *
  chartInstance, const mxArray *c2_imnoise, const char_T *c2_identifier, uint8_T
  c2_y[76800]);
static void c2_c_emlrt_marshallIn(SFc2_hdlcoder_medianimagefilterInstanceStruct *
  chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  uint8_T c2_y[76800]);
static const mxArray *c2_d_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static int32_T c2_d_emlrt_marshallIn
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance, const mxArray
   *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static uint8_T c2_e_emlrt_marshallIn
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance, const mxArray
   *c2_b_is_active_c2_hdlcoder_medianimagefilter, const char_T *c2_identifier);
static uint8_T c2_f_emlrt_marshallIn
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance, const mxArray
   *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void init_dsm_address_info(SFc2_hdlcoder_medianimagefilterInstanceStruct *
  chartInstance);
static void init_simulink_io_address
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance)
{
  emlrtLicenseCheckR2012b(chartInstance->c2_fEmlrtCtx, "Image_Toolbox", 2);
  if (sf_is_first_init_cond(chartInstance->S)) {
    initSimStructsc2_hdlcoder_medianimagefilter(chartInstance);
    chart_debug_initialize_data_addresses(chartInstance->S);
  }

  chartInstance->c2_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c2_is_active_c2_hdlcoder_medianimagefilter = 0U;
}

static void initialize_params_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c2_update_debugger_state_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance)
{
  const mxArray *c2_st;
  const mxArray *c2_y = NULL;
  const mxArray *c2_b_y = NULL;
  uint8_T c2_hoistedGlobal;
  const mxArray *c2_c_y = NULL;
  c2_st = NULL;
  c2_st = NULL;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_createcellmatrix(2, 1), false);
  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", *chartInstance->c2_b_ImageOut, 3, 0U,
    1U, 0U, 2, 240, 320), false);
  sf_mex_setcell(c2_y, 0, c2_b_y);
  c2_hoistedGlobal = chartInstance->c2_is_active_c2_hdlcoder_medianimagefilter;
  c2_c_y = NULL;
  sf_mex_assign(&c2_c_y, sf_mex_create("y", &c2_hoistedGlobal, 3, 0U, 0U, 0U, 0),
                false);
  sf_mex_setcell(c2_y, 1, c2_c_y);
  sf_mex_assign(&c2_st, c2_y, false);
  return c2_st;
}

static void set_sim_state_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance, const mxArray
   *c2_st)
{
  const mxArray *c2_u;
  uint8_T c2_uv0[76800];
  int32_T c2_i0;
  chartInstance->c2_doneDoubleBufferReInit = true;
  c2_u = sf_mex_dup(c2_st);
  c2_b_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 0)),
                        "ImageOut", c2_uv0);
  for (c2_i0 = 0; c2_i0 < 76800; c2_i0++) {
    (*chartInstance->c2_b_ImageOut)[c2_i0] = c2_uv0[c2_i0];
  }

  chartInstance->c2_is_active_c2_hdlcoder_medianimagefilter =
    c2_e_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 1)),
    "is_active_c2_hdlcoder_medianimagefilter");
  sf_mex_destroy(&c2_u);
  c2_update_debugger_state_c2_hdlcoder_medianimagefilter(chartInstance);
  sf_mex_destroy(&c2_st);
}

static void finalize_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void sf_gateway_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance)
{
  int32_T c2_i1;
  int32_T c2_i2;
  _SFD_SYMBOL_SCOPE_PUSH(0U, 0U);
  _sfTime_ = sf_get_time(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0U, chartInstance->c2_sfEvent);
  _SFD_DATA_RANGE_CHECK(*chartInstance->c2_density, 1U);
  for (c2_i1 = 0; c2_i1 < 76800; c2_i1++) {
    _SFD_DATA_RANGE_CHECK((real_T)(*chartInstance->c2_c_ImageIn)[c2_i1], 0U);
  }

  chartInstance->c2_sfEvent = CALL_EVENT;
  c2_chartstep_c2_hdlcoder_medianimagefilter(chartInstance);
  _SFD_SYMBOL_SCOPE_POP();
  for (c2_i2 = 0; c2_i2 < 76800; c2_i2++) {
    _SFD_DATA_RANGE_CHECK((real_T)(*chartInstance->c2_b_ImageOut)[c2_i2], 2U);
  }
}

static void mdl_start_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance)
{
  sim_mode_is_external(chartInstance->S);
}

static void c2_chartstep_c2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance)
{
  real_T c2_hoistedGlobal;
  int32_T c2_i3;
  real_T c2_b_density;
  uint32_T c2_debug_family_var_map[7];
  real_T c2_coeff[9];
  real_T c2_nargin = 2.0;
  real_T c2_nargout = 1.0;
  int32_T c2_i4;
  int32_T c2_i5;
  int32_T c2_i6;
  int32_T c2_i7;
  static char_T c2_cv0[13] = { 's', 'a', 'l', 't', ' ', '&', ' ', 'p', 'e', 'p',
    'p', 'e', 'r' };

  int32_T c2_i8;
  int32_T c2_i9;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c2_sfEvent);
  c2_hoistedGlobal = *chartInstance->c2_density;
  for (c2_i3 = 0; c2_i3 < 76800; c2_i3++) {
    chartInstance->c2_ImageIn[c2_i3] = (*chartInstance->c2_c_ImageIn)[c2_i3];
  }

  c2_b_density = c2_hoistedGlobal;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 7U, 7U, c2_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML(c2_coeff, 0U, c2_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(chartInstance->c2_ImageBlur, 1U,
    c2_b_sf_marshallOut, c2_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 2U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 3U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(chartInstance->c2_ImageIn, 4U, c2_b_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_b_density, 5U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(chartInstance->c2_ImageOut, 6U,
    c2_b_sf_marshallOut, c2_sf_marshallIn);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 3);
  for (c2_i4 = 0; c2_i4 < 76800; c2_i4++) {
    chartInstance->c2_ImageOut[c2_i4] = 0U;
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 4);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 5);
  for (c2_i5 = 0; c2_i5 < 9; c2_i5++) {
    c2_coeff[c2_i5] = 0.1111111111111111;
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 6);
  for (c2_i6 = 0; c2_i6 < 76800; c2_i6++) {
    chartInstance->c2_b_ImageIn[c2_i6] = chartInstance->c2_ImageIn[c2_i6];
  }

  c2_imfilter(chartInstance, chartInstance->c2_b_ImageIn, chartInstance->c2_uv1);
  for (c2_i7 = 0; c2_i7 < 76800; c2_i7++) {
    chartInstance->c2_ImageBlur[c2_i7] = chartInstance->c2_uv1[c2_i7];
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 7);
  c2_b_emlrt_marshallIn(chartInstance, sf_mex_call_debug
                        (sfGlobalDebugInstanceStruct, "imnoise", 1U, 3U, 14,
    c2_emlrt_marshallOut(chartInstance, chartInstance->c2_ImageBlur), 14,
    c2_b_emlrt_marshallOut(chartInstance, c2_cv0), 14, c2_c_emlrt_marshallOut
    (chartInstance, c2_b_density)), "imnoise", chartInstance->c2_uv2);
  for (c2_i8 = 0; c2_i8 < 76800; c2_i8++) {
    chartInstance->c2_ImageOut[c2_i8] = chartInstance->c2_uv2[c2_i8];
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, -7);
  _SFD_SYMBOL_SCOPE_POP();
  for (c2_i9 = 0; c2_i9 < 76800; c2_i9++) {
    (*chartInstance->c2_b_ImageOut)[c2_i9] = chartInstance->c2_ImageOut[c2_i9];
  }

  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c2_sfEvent);
}

static void initSimStructsc2_hdlcoder_medianimagefilter
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber, uint32_T c2_instanceNumber)
{
  (void)(c2_machineNumber);
  (void)(c2_chartNumber);
  (void)(c2_instanceNumber);
}

static const mxArray *c2_sf_marshallOut(void *chartInstanceVoid, void *c2_inData)
{
  const mxArray *c2_mxArrayOutData;
  int32_T c2_i10;
  int32_T c2_i11;
  const mxArray *c2_y = NULL;
  int32_T c2_i12;
  real_T c2_u[9];
  SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance;
  chartInstance = (SFc2_hdlcoder_medianimagefilterInstanceStruct *)
    chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_mxArrayOutData = NULL;
  c2_i10 = 0;
  for (c2_i11 = 0; c2_i11 < 3; c2_i11++) {
    for (c2_i12 = 0; c2_i12 < 3; c2_i12++) {
      c2_u[c2_i12 + c2_i10] = (*(real_T (*)[9])c2_inData)[c2_i12 + c2_i10];
    }

    c2_i10 += 3;
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 2, 3, 3), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static const mxArray *c2_b_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData;
  int32_T c2_i13;
  int32_T c2_i14;
  const mxArray *c2_y = NULL;
  int32_T c2_i15;
  uint8_T c2_u[76800];
  SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance;
  chartInstance = (SFc2_hdlcoder_medianimagefilterInstanceStruct *)
    chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_mxArrayOutData = NULL;
  c2_i13 = 0;
  for (c2_i14 = 0; c2_i14 < 320; c2_i14++) {
    for (c2_i15 = 0; c2_i15 < 240; c2_i15++) {
      c2_u[c2_i15 + c2_i13] = (*(uint8_T (*)[76800])c2_inData)[c2_i15 + c2_i13];
    }

    c2_i13 += 240;
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 3, 0U, 1U, 0U, 2, 240, 320),
                false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static void c2_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_imnoise;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  uint8_T c2_y[76800];
  int32_T c2_i16;
  int32_T c2_i17;
  int32_T c2_i18;
  SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance;
  chartInstance = (SFc2_hdlcoder_medianimagefilterInstanceStruct *)
    chartInstanceVoid;
  c2_imnoise = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = (const char *)c2_identifier;
  c2_thisId.fParent = NULL;
  c2_thisId.bParentIsCell = false;
  c2_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_imnoise), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_imnoise);
  c2_i16 = 0;
  for (c2_i17 = 0; c2_i17 < 320; c2_i17++) {
    for (c2_i18 = 0; c2_i18 < 240; c2_i18++) {
      (*(uint8_T (*)[76800])c2_outData)[c2_i18 + c2_i16] = c2_y[c2_i18 + c2_i16];
    }

    c2_i16 += 240;
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_c_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData;
  real_T c2_u;
  const mxArray *c2_y = NULL;
  SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance;
  chartInstance = (SFc2_hdlcoder_medianimagefilterInstanceStruct *)
    chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_mxArrayOutData = NULL;
  c2_u = *(real_T *)c2_inData;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static real_T c2_emlrt_marshallIn(SFc2_hdlcoder_medianimagefilterInstanceStruct *
  chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  real_T c2_y;
  real_T c2_d0;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_d0, 1, 0, 0U, 0, 0U, 0);
  c2_y = c2_d0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_nargin;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y;
  SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance;
  chartInstance = (SFc2_hdlcoder_medianimagefilterInstanceStruct *)
    chartInstanceVoid;
  c2_nargin = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = (const char *)c2_identifier;
  c2_thisId.fParent = NULL;
  c2_thisId.bParentIsCell = false;
  c2_y = c2_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_nargin), &c2_thisId);
  sf_mex_destroy(&c2_nargin);
  *(real_T *)c2_outData = c2_y;
  sf_mex_destroy(&c2_mxArrayInData);
}

const mxArray *sf_c2_hdlcoder_medianimagefilter_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c2_nameCaptureInfo = NULL;
  c2_nameCaptureInfo = NULL;
  sf_mex_assign(&c2_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c2_nameCaptureInfo;
}

static void c2_imfilter(SFc2_hdlcoder_medianimagefilterInstanceStruct
  *chartInstance, uint8_T c2_b_varargin_1[76800], uint8_T c2_b[76800])
{
  int32_T c2_i19;
  boolean_T c2_tooBig;
  int32_T c2_i;
  real_T c2_b_i;
  boolean_T c2_modeFlag;
  boolean_T c2_b_tooBig;
  boolean_T c2_b_modeFlag;
  boolean_T c2_c_modeFlag;
  int32_T c2_i20;
  int32_T c2_i21;
  int32_T c2_i22;
  real_T c2_nonZeroKernel[9];
  int32_T c2_i23;
  int32_T c2_i24;
  boolean_T c2_conn[9];
  int32_T c2_i25;
  real_T c2_padSizeT[2];
  int32_T c2_i26;
  int32_T c2_i27;
  real_T c2_outSizeT[2];
  int32_T c2_i28;
  real_T c2_connDimsT[2];
  int32_T c2_i29;
  real_T c2_startT[2];
  for (c2_i19 = 0; c2_i19 < 76800; c2_i19++) {
    chartInstance->c2_varargin_1[c2_i19] = c2_b_varargin_1[c2_i19];
  }

  c2_padImage(chartInstance, chartInstance->c2_varargin_1, 0.0, 0, 0.0,
              chartInstance->c2_a);
  c2_tooBig = true;
  for (c2_i = 0; c2_i < 2; c2_i++) {
    c2_b_i = 1.0 + (real_T)c2_i;
    if (c2_tooBig && (240.0 + 80.0 * (real_T)(sf_eml_array_bounds_check
          (sfGlobalDebugInstanceStruct, chartInstance->S, 1U, 0, 0, MAX_uint32_T,
           (int32_T)sf_integer_check(chartInstance->S, 1U, 0U, 0U, c2_b_i), 1, 2)
          - 1) > 65500.0)) {
      c2_b_tooBig = true;
    } else {
      c2_b_tooBig = false;
    }

    c2_tooBig = c2_b_tooBig;
  }

  if (!c2_tooBig) {
    c2_modeFlag = true;
  } else {
    c2_modeFlag = false;
  }

  if (c2_modeFlag) {
    c2_b_modeFlag = true;
  } else {
    c2_b_modeFlag = false;
  }

  c2_c_modeFlag = c2_b_modeFlag;
  if (c2_c_modeFlag) {
    for (c2_i21 = 0; c2_i21 < 9; c2_i21++) {
      c2_nonZeroKernel[c2_i21] = 0.1111111111111111;
    }

    for (c2_i23 = 0; c2_i23 < 2; c2_i23++) {
      c2_padSizeT[c2_i23] = 242.0 + 80.0 * (real_T)c2_i23;
    }

    for (c2_i25 = 0; c2_i25 < 2; c2_i25++) {
      c2_outSizeT[c2_i25] = 240.0 + 80.0 * (real_T)c2_i25;
    }

    for (c2_i27 = 0; c2_i27 < 2; c2_i27++) {
      c2_connDimsT[c2_i27] = 3.0;
    }

    ippfilter_uint8(chartInstance->c2_a, c2_b, c2_outSizeT, 2.0, c2_padSizeT,
                    c2_nonZeroKernel, c2_connDimsT, false);
  } else {
    for (c2_i20 = 0; c2_i20 < 9; c2_i20++) {
      c2_nonZeroKernel[c2_i20] = 0.1111111111111111;
    }

    for (c2_i22 = 0; c2_i22 < 9; c2_i22++) {
      c2_conn[c2_i22] = true;
    }

    for (c2_i24 = 0; c2_i24 < 2; c2_i24++) {
      c2_padSizeT[c2_i24] = 242.0 + 80.0 * (real_T)c2_i24;
    }

    for (c2_i26 = 0; c2_i26 < 2; c2_i26++) {
      c2_outSizeT[c2_i26] = 240.0 + 80.0 * (real_T)c2_i26;
    }

    for (c2_i28 = 0; c2_i28 < 2; c2_i28++) {
      c2_connDimsT[c2_i28] = 3.0;
    }

    for (c2_i29 = 0; c2_i29 < 2; c2_i29++) {
      c2_startT[c2_i29] = 1.0;
    }

    imfilter_uint8(chartInstance->c2_a, c2_b, 2.0, c2_outSizeT, 2.0, c2_padSizeT,
                   c2_nonZeroKernel, 9.0, c2_conn, 2.0, c2_connDimsT, c2_startT,
                   2.0, true, false);
  }
}

static void c2_padImage(SFc2_hdlcoder_medianimagefilterInstanceStruct
  *chartInstance, uint8_T c2_a_tmp[76800], real_T c2_boundary_pos, int8_T
  c2_boundaryEnum, real_T c2_boundaryStr_pos, uint8_T c2_b_a[77924])
{
  int32_T c2_i30;
  int32_T c2_j;
  uint8_T c2_b_a_tmp[76800];
  int32_T c2_i;
  int32_T c2_i31;
  real_T c2_b_j;
  int32_T c2_b_i;
  int32_T c2_c_i;
  real_T c2_d_i;
  uint8_T c2_c_a_tmp[76800];
  real_T c2_e_i;
  int32_T c2_c_j;
  static int32_T c2_idxA[644] = { 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
    14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
    33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
    71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89,
    90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106,
    107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121,
    122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136,
    137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151,
    152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166,
    167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181,
    182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196,
    197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211,
    212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226,
    227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 240, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
    21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39,
    40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58,
    59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77,
    78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96,
    97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112,
    113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127,
    128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142,
    143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157,
    158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172,
    173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187,
    188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202,
    203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217,
    218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232,
    233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247,
    248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262,
    263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277,
    278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292,
    293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307,
    308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 320 };

  int32_T c2_d_j;
  real_T c2_e_j;
  real_T c2_c_a;
  int32_T c2_c;
  int32_T c2_f_j;
  real_T c2_d_a;
  int32_T c2_b_c;
  int32_T c2_f_i;
  real_T c2_e_a;
  int32_T c2_c_c;
  real_T c2_f_a;
  int32_T c2_d_c;
  if ((c2_boundaryEnum == 4) && (c2_boundary_pos < c2_boundaryStr_pos)) {
    for (c2_i30 = 0; c2_i30 < 76800; c2_i30++) {
      c2_b_a_tmp[c2_i30] = c2_a_tmp[c2_i30];
    }

    c2_padarray(chartInstance, c2_b_a_tmp, c2_b_a);
  } else if ((c2_boundaryEnum == 3) && (c2_boundary_pos < c2_boundaryStr_pos)) {
    for (c2_j = 0; c2_j < 322; c2_j++) {
      c2_b_j = 1.0 + (real_T)c2_j;
      for (c2_b_i = 0; c2_b_i < 242; c2_b_i++) {
        c2_e_i = 1.0 + (real_T)c2_b_i;
        c2_b_a[(sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
                 chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)
                 sf_integer_check(chartInstance->S, 1U, 0U, 0U, c2_e_i), 1, 242)
                + 242 * (sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
                  chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)
                  sf_integer_check(chartInstance->S, 1U, 0U, 0U, c2_b_j), 1, 322)
                         - 1)) - 1] = c2_a_tmp[(sf_eml_array_bounds_check
          (sfGlobalDebugInstanceStruct, chartInstance->S, 1U, 0, 0, MAX_uint32_T,
           (int32_T)sf_integer_check(chartInstance->S, 1U, 0U, 0U, (real_T)
          c2_idxA[sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
          chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)sf_integer_check
          (chartInstance->S, 1U, 0U, 0U, c2_e_i), 1, 322) - 1]), 1, 240) + 240 *
          (sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
          chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)sf_integer_check
          (chartInstance->S, 1U, 0U, 0U, (real_T)
           c2_idxA[sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
          chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)sf_integer_check
          (chartInstance->S, 1U, 0U, 0U, c2_b_j), 1, 322) + 321]), 1, 320) - 1))
          - 1];
      }
    }
  } else if ((c2_boundaryEnum == 2) && (c2_boundary_pos < c2_boundaryStr_pos)) {
    for (c2_i31 = 0; c2_i31 < 76800; c2_i31++) {
      c2_c_a_tmp[c2_i31] = c2_a_tmp[c2_i31];
    }

    c2_b_padarray(chartInstance, c2_c_a_tmp, c2_b_a);
  } else {
    for (c2_i = 0; c2_i < 242; c2_i++) {
      c2_d_i = 1.0 + (real_T)c2_i;
      c2_b_a[sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
        chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)sf_integer_check
        (chartInstance->S, 1U, 0U, 0U, c2_d_i), 1, 242) - 1] = 0U;
    }

    for (c2_c_i = 0; c2_c_i < 242; c2_c_i++) {
      c2_d_i = 1.0 + (real_T)c2_c_i;
      c2_b_a[sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
        chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)sf_integer_check
        (chartInstance->S, 1U, 0U, 0U, c2_d_i), 1, 242) + 77681] = 0U;
    }

    for (c2_c_j = 0; c2_c_j < 320; c2_c_j++) {
      c2_e_j = 1.0 + (real_T)c2_c_j;
      c2_c_a = c2_e_j;
      c2_c = (int32_T)c2_c_a;
      c2_b_a[242 * (sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
        chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)sf_integer_check
        (chartInstance->S, 1U, 0U, 0U, (real_T)(c2_c + 1)), 1, 322) - 1)] = 0U;
    }

    for (c2_d_j = 0; c2_d_j < 320; c2_d_j++) {
      c2_e_j = 1.0 + (real_T)c2_d_j;
      c2_d_a = c2_e_j;
      c2_b_c = (int32_T)c2_d_a;
      c2_b_a[241 + 242 * (sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
        chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)sf_integer_check
        (chartInstance->S, 1U, 0U, 0U, (real_T)(c2_b_c + 1)), 1, 322) - 1)] = 0U;
    }

    for (c2_f_j = 0; c2_f_j < 320; c2_f_j++) {
      c2_e_j = 1.0 + (real_T)c2_f_j;
      for (c2_f_i = 0; c2_f_i < 240; c2_f_i++) {
        c2_d_i = 1.0 + (real_T)c2_f_i;
        c2_e_a = c2_d_i;
        c2_c_c = (int32_T)c2_e_a;
        c2_f_a = c2_e_j;
        c2_d_c = (int32_T)c2_f_a;
        c2_b_a[(sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
                 chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)
                 sf_integer_check(chartInstance->S, 1U, 0U, 0U, (real_T)(c2_c_c
                   + 1)), 1, 242) + 242 * (sf_eml_array_bounds_check
                 (sfGlobalDebugInstanceStruct, chartInstance->S, 1U, 0, 0,
                  MAX_uint32_T, (int32_T)sf_integer_check(chartInstance->S, 1U,
                   0U, 0U, (real_T)(c2_d_c + 1)), 1, 322) - 1)) - 1] = c2_a_tmp
          [(sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
             chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)sf_integer_check
             (chartInstance->S, 1U, 0U, 0U, c2_d_i), 1, 240) + 240 *
            (sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
              chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)
              sf_integer_check(chartInstance->S, 1U, 0U, 0U, c2_e_j), 1, 320) -
             1)) - 1];
      }
    }
  }
}

static void c2_padarray(SFc2_hdlcoder_medianimagefilterInstanceStruct
  *chartInstance, uint8_T c2_b_varargin_1[76800], uint8_T c2_b[77924])
{
  int32_T c2_i32;
  real_T c2_dv0[242];
  real_T c2_dv1[242];
  int32_T c2_i33;
  int32_T c2_i34;
  uint32_T c2_idxDir[242];
  int32_T c2_i35;
  int32_T c2_idxA[644];
  real_T c2_dv2[322];
  real_T c2_dv3[322];
  int32_T c2_i36;
  int32_T c2_i37;
  uint32_T c2_b_idxDir[322];
  int32_T c2_j;
  real_T c2_b_j;
  int32_T c2_i;
  real_T c2_b_i;
  for (c2_i32 = 0; c2_i32 < 242; c2_i32++) {
    c2_dv0[c2_i32] = -1.0 + (real_T)c2_i32;
  }

  c2_mod(chartInstance, c2_dv0, c2_dv1);
  for (c2_i33 = 0; c2_i33 < 242; c2_i33++) {
    c2_idxDir[c2_i33] = (uint32_T)sf_eml_array_bounds_check
      (sfGlobalDebugInstanceStruct, chartInstance->S, 1U, 0, 0, MAX_uint32_T,
       (int32_T)sf_integer_check(chartInstance->S, 1U, 0U, 0U, c2_dv1[c2_i33] +
        1.0), 1, 240);
  }

  for (c2_i34 = 0; c2_i34 < 242; c2_i34++) {
    c2_idxA[c2_i34] = (int32_T)c2_idxDir[c2_i34];
  }

  for (c2_i35 = 0; c2_i35 < 322; c2_i35++) {
    c2_dv2[c2_i35] = -1.0 + (real_T)c2_i35;
  }

  c2_b_mod(chartInstance, c2_dv2, c2_dv3);
  for (c2_i36 = 0; c2_i36 < 322; c2_i36++) {
    c2_b_idxDir[c2_i36] = (uint32_T)sf_eml_array_bounds_check
      (sfGlobalDebugInstanceStruct, chartInstance->S, 1U, 0, 0, MAX_uint32_T,
       (int32_T)sf_integer_check(chartInstance->S, 1U, 0U, 0U, c2_dv3[c2_i36] +
        1.0), 1, 320);
  }

  for (c2_i37 = 0; c2_i37 < 322; c2_i37++) {
    c2_idxA[c2_i37 + 322] = (int32_T)c2_b_idxDir[c2_i37];
  }

  for (c2_j = 0; c2_j < 322; c2_j++) {
    c2_b_j = 1.0 + (real_T)c2_j;
    for (c2_i = 0; c2_i < 242; c2_i++) {
      c2_b_i = 1.0 + (real_T)c2_i;
      c2_b[(sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
             chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)sf_integer_check
             (chartInstance->S, 1U, 0U, 0U, c2_b_i), 1, 242) + 242 *
            (sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
              chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)
              sf_integer_check(chartInstance->S, 1U, 0U, 0U, c2_b_j), 1, 322) -
             1)) - 1] = c2_b_varargin_1[(sf_eml_array_bounds_check
        (sfGlobalDebugInstanceStruct, chartInstance->S, 1U, 0, 0, MAX_uint32_T,
         (int32_T)sf_integer_check(chartInstance->S, 1U, 0U, 0U, (real_T)
        c2_idxA[sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
        chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)sf_integer_check
        (chartInstance->S, 1U, 0U, 0U, c2_b_i), 1, 322) - 1]), 1, 240) + 240 *
        (sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct, chartInstance->S,
        1U, 0, 0, MAX_uint32_T, (int32_T)sf_integer_check(chartInstance->S, 1U,
        0U, 0U, (real_T)c2_idxA[sf_eml_array_bounds_check
        (sfGlobalDebugInstanceStruct, chartInstance->S, 1U, 0, 0, MAX_uint32_T,
         (int32_T)sf_integer_check(chartInstance->S, 1U, 0U, 0U, c2_b_j), 1, 322)
        + 321]), 1, 320) - 1)) - 1];
    }
  }
}

static void c2_mod(SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance,
                   real_T c2_x[242], real_T c2_r[242])
{
  int32_T c2_k;
  real_T c2_b_x;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_e_x;
  boolean_T c2_b;
  boolean_T c2_b0;
  real_T c2_f_x;
  boolean_T c2_b_b;
  boolean_T c2_b1;
  boolean_T c2_c_b;
  real_T c2_b_r;
  boolean_T c2_rEQ0;
  (void)chartInstance;
  for (c2_k = 0; c2_k < 242; c2_k++) {
    c2_b_x = c2_x[c2_k];
    c2_c_x = c2_b_x;
    c2_d_x = c2_c_x;
    c2_e_x = c2_d_x;
    c2_b = muDoubleScalarIsInf(c2_e_x);
    c2_b0 = !c2_b;
    c2_f_x = c2_d_x;
    c2_b_b = muDoubleScalarIsNaN(c2_f_x);
    c2_b1 = !c2_b_b;
    c2_c_b = (c2_b0 && c2_b1);
    if (c2_c_b) {
      if (c2_c_x == 0.0) {
        c2_b_r = 0.0;
      } else {
        c2_b_r = muDoubleScalarRem(c2_c_x, 240.0);
        c2_rEQ0 = (c2_b_r == 0.0);
        if (c2_rEQ0) {
          c2_b_r = 0.0;
        } else {
          if (c2_c_x < 0.0) {
            c2_b_r += 240.0;
          }
        }
      }
    } else {
      c2_b_r = rtNaN;
    }

    c2_r[c2_k] = c2_b_r;
  }
}

static void c2_b_mod(SFc2_hdlcoder_medianimagefilterInstanceStruct
                     *chartInstance, real_T c2_x[322], real_T c2_r[322])
{
  int32_T c2_k;
  real_T c2_b_x;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_e_x;
  boolean_T c2_b;
  boolean_T c2_b2;
  real_T c2_f_x;
  boolean_T c2_b_b;
  boolean_T c2_b3;
  boolean_T c2_c_b;
  real_T c2_b_r;
  boolean_T c2_rEQ0;
  (void)chartInstance;
  for (c2_k = 0; c2_k < 322; c2_k++) {
    c2_b_x = c2_x[c2_k];
    c2_c_x = c2_b_x;
    c2_d_x = c2_c_x;
    c2_e_x = c2_d_x;
    c2_b = muDoubleScalarIsInf(c2_e_x);
    c2_b2 = !c2_b;
    c2_f_x = c2_d_x;
    c2_b_b = muDoubleScalarIsNaN(c2_f_x);
    c2_b3 = !c2_b_b;
    c2_c_b = (c2_b2 && c2_b3);
    if (c2_c_b) {
      if (c2_c_x == 0.0) {
        c2_b_r = 0.0;
      } else {
        c2_b_r = muDoubleScalarRem(c2_c_x, 320.0);
        c2_rEQ0 = (c2_b_r == 0.0);
        if (c2_rEQ0) {
          c2_b_r = 0.0;
        } else {
          if (c2_c_x < 0.0) {
            c2_b_r += 320.0;
          }
        }
      }
    } else {
      c2_b_r = rtNaN;
    }

    c2_r[c2_k] = c2_b_r;
  }
}

static void c2_b_padarray(SFc2_hdlcoder_medianimagefilterInstanceStruct
  *chartInstance, uint8_T c2_b_varargin_1[76800], uint8_T c2_b[77924])
{
  int32_T c2_i38;
  real_T c2_dv4[242];
  real_T c2_dv5[242];
  int32_T c2_i39;
  int32_T c2_i40;
  uint32_T c2_idxDir[242];
  static uint32_T c2_uv3[480] = { 1U, 2U, 3U, 4U, 5U, 6U, 7U, 8U, 9U, 10U, 11U,
    12U, 13U, 14U, 15U, 16U, 17U, 18U, 19U, 20U, 21U, 22U, 23U, 24U, 25U, 26U,
    27U, 28U, 29U, 30U, 31U, 32U, 33U, 34U, 35U, 36U, 37U, 38U, 39U, 40U, 41U,
    42U, 43U, 44U, 45U, 46U, 47U, 48U, 49U, 50U, 51U, 52U, 53U, 54U, 55U, 56U,
    57U, 58U, 59U, 60U, 61U, 62U, 63U, 64U, 65U, 66U, 67U, 68U, 69U, 70U, 71U,
    72U, 73U, 74U, 75U, 76U, 77U, 78U, 79U, 80U, 81U, 82U, 83U, 84U, 85U, 86U,
    87U, 88U, 89U, 90U, 91U, 92U, 93U, 94U, 95U, 96U, 97U, 98U, 99U, 100U, 101U,
    102U, 103U, 104U, 105U, 106U, 107U, 108U, 109U, 110U, 111U, 112U, 113U, 114U,
    115U, 116U, 117U, 118U, 119U, 120U, 121U, 122U, 123U, 124U, 125U, 126U, 127U,
    128U, 129U, 130U, 131U, 132U, 133U, 134U, 135U, 136U, 137U, 138U, 139U, 140U,
    141U, 142U, 143U, 144U, 145U, 146U, 147U, 148U, 149U, 150U, 151U, 152U, 153U,
    154U, 155U, 156U, 157U, 158U, 159U, 160U, 161U, 162U, 163U, 164U, 165U, 166U,
    167U, 168U, 169U, 170U, 171U, 172U, 173U, 174U, 175U, 176U, 177U, 178U, 179U,
    180U, 181U, 182U, 183U, 184U, 185U, 186U, 187U, 188U, 189U, 190U, 191U, 192U,
    193U, 194U, 195U, 196U, 197U, 198U, 199U, 200U, 201U, 202U, 203U, 204U, 205U,
    206U, 207U, 208U, 209U, 210U, 211U, 212U, 213U, 214U, 215U, 216U, 217U, 218U,
    219U, 220U, 221U, 222U, 223U, 224U, 225U, 226U, 227U, 228U, 229U, 230U, 231U,
    232U, 233U, 234U, 235U, 236U, 237U, 238U, 239U, 240U, 240U, 239U, 238U, 237U,
    236U, 235U, 234U, 233U, 232U, 231U, 230U, 229U, 228U, 227U, 226U, 225U, 224U,
    223U, 222U, 221U, 220U, 219U, 218U, 217U, 216U, 215U, 214U, 213U, 212U, 211U,
    210U, 209U, 208U, 207U, 206U, 205U, 204U, 203U, 202U, 201U, 200U, 199U, 198U,
    197U, 196U, 195U, 194U, 193U, 192U, 191U, 190U, 189U, 188U, 187U, 186U, 185U,
    184U, 183U, 182U, 181U, 180U, 179U, 178U, 177U, 176U, 175U, 174U, 173U, 172U,
    171U, 170U, 169U, 168U, 167U, 166U, 165U, 164U, 163U, 162U, 161U, 160U, 159U,
    158U, 157U, 156U, 155U, 154U, 153U, 152U, 151U, 150U, 149U, 148U, 147U, 146U,
    145U, 144U, 143U, 142U, 141U, 140U, 139U, 138U, 137U, 136U, 135U, 134U, 133U,
    132U, 131U, 130U, 129U, 128U, 127U, 126U, 125U, 124U, 123U, 122U, 121U, 120U,
    119U, 118U, 117U, 116U, 115U, 114U, 113U, 112U, 111U, 110U, 109U, 108U, 107U,
    106U, 105U, 104U, 103U, 102U, 101U, 100U, 99U, 98U, 97U, 96U, 95U, 94U, 93U,
    92U, 91U, 90U, 89U, 88U, 87U, 86U, 85U, 84U, 83U, 82U, 81U, 80U, 79U, 78U,
    77U, 76U, 75U, 74U, 73U, 72U, 71U, 70U, 69U, 68U, 67U, 66U, 65U, 64U, 63U,
    62U, 61U, 60U, 59U, 58U, 57U, 56U, 55U, 54U, 53U, 52U, 51U, 50U, 49U, 48U,
    47U, 46U, 45U, 44U, 43U, 42U, 41U, 40U, 39U, 38U, 37U, 36U, 35U, 34U, 33U,
    32U, 31U, 30U, 29U, 28U, 27U, 26U, 25U, 24U, 23U, 22U, 21U, 20U, 19U, 18U,
    17U, 16U, 15U, 14U, 13U, 12U, 11U, 10U, 9U, 8U, 7U, 6U, 5U, 4U, 3U, 2U, 1U };

  int32_T c2_i41;
  int32_T c2_idxA[644];
  real_T c2_dv6[322];
  real_T c2_dv7[322];
  int32_T c2_i42;
  int32_T c2_i43;
  uint32_T c2_b_idxDir[322];
  static uint32_T c2_uv4[640] = { 1U, 2U, 3U, 4U, 5U, 6U, 7U, 8U, 9U, 10U, 11U,
    12U, 13U, 14U, 15U, 16U, 17U, 18U, 19U, 20U, 21U, 22U, 23U, 24U, 25U, 26U,
    27U, 28U, 29U, 30U, 31U, 32U, 33U, 34U, 35U, 36U, 37U, 38U, 39U, 40U, 41U,
    42U, 43U, 44U, 45U, 46U, 47U, 48U, 49U, 50U, 51U, 52U, 53U, 54U, 55U, 56U,
    57U, 58U, 59U, 60U, 61U, 62U, 63U, 64U, 65U, 66U, 67U, 68U, 69U, 70U, 71U,
    72U, 73U, 74U, 75U, 76U, 77U, 78U, 79U, 80U, 81U, 82U, 83U, 84U, 85U, 86U,
    87U, 88U, 89U, 90U, 91U, 92U, 93U, 94U, 95U, 96U, 97U, 98U, 99U, 100U, 101U,
    102U, 103U, 104U, 105U, 106U, 107U, 108U, 109U, 110U, 111U, 112U, 113U, 114U,
    115U, 116U, 117U, 118U, 119U, 120U, 121U, 122U, 123U, 124U, 125U, 126U, 127U,
    128U, 129U, 130U, 131U, 132U, 133U, 134U, 135U, 136U, 137U, 138U, 139U, 140U,
    141U, 142U, 143U, 144U, 145U, 146U, 147U, 148U, 149U, 150U, 151U, 152U, 153U,
    154U, 155U, 156U, 157U, 158U, 159U, 160U, 161U, 162U, 163U, 164U, 165U, 166U,
    167U, 168U, 169U, 170U, 171U, 172U, 173U, 174U, 175U, 176U, 177U, 178U, 179U,
    180U, 181U, 182U, 183U, 184U, 185U, 186U, 187U, 188U, 189U, 190U, 191U, 192U,
    193U, 194U, 195U, 196U, 197U, 198U, 199U, 200U, 201U, 202U, 203U, 204U, 205U,
    206U, 207U, 208U, 209U, 210U, 211U, 212U, 213U, 214U, 215U, 216U, 217U, 218U,
    219U, 220U, 221U, 222U, 223U, 224U, 225U, 226U, 227U, 228U, 229U, 230U, 231U,
    232U, 233U, 234U, 235U, 236U, 237U, 238U, 239U, 240U, 241U, 242U, 243U, 244U,
    245U, 246U, 247U, 248U, 249U, 250U, 251U, 252U, 253U, 254U, 255U, 256U, 257U,
    258U, 259U, 260U, 261U, 262U, 263U, 264U, 265U, 266U, 267U, 268U, 269U, 270U,
    271U, 272U, 273U, 274U, 275U, 276U, 277U, 278U, 279U, 280U, 281U, 282U, 283U,
    284U, 285U, 286U, 287U, 288U, 289U, 290U, 291U, 292U, 293U, 294U, 295U, 296U,
    297U, 298U, 299U, 300U, 301U, 302U, 303U, 304U, 305U, 306U, 307U, 308U, 309U,
    310U, 311U, 312U, 313U, 314U, 315U, 316U, 317U, 318U, 319U, 320U, 320U, 319U,
    318U, 317U, 316U, 315U, 314U, 313U, 312U, 311U, 310U, 309U, 308U, 307U, 306U,
    305U, 304U, 303U, 302U, 301U, 300U, 299U, 298U, 297U, 296U, 295U, 294U, 293U,
    292U, 291U, 290U, 289U, 288U, 287U, 286U, 285U, 284U, 283U, 282U, 281U, 280U,
    279U, 278U, 277U, 276U, 275U, 274U, 273U, 272U, 271U, 270U, 269U, 268U, 267U,
    266U, 265U, 264U, 263U, 262U, 261U, 260U, 259U, 258U, 257U, 256U, 255U, 254U,
    253U, 252U, 251U, 250U, 249U, 248U, 247U, 246U, 245U, 244U, 243U, 242U, 241U,
    240U, 239U, 238U, 237U, 236U, 235U, 234U, 233U, 232U, 231U, 230U, 229U, 228U,
    227U, 226U, 225U, 224U, 223U, 222U, 221U, 220U, 219U, 218U, 217U, 216U, 215U,
    214U, 213U, 212U, 211U, 210U, 209U, 208U, 207U, 206U, 205U, 204U, 203U, 202U,
    201U, 200U, 199U, 198U, 197U, 196U, 195U, 194U, 193U, 192U, 191U, 190U, 189U,
    188U, 187U, 186U, 185U, 184U, 183U, 182U, 181U, 180U, 179U, 178U, 177U, 176U,
    175U, 174U, 173U, 172U, 171U, 170U, 169U, 168U, 167U, 166U, 165U, 164U, 163U,
    162U, 161U, 160U, 159U, 158U, 157U, 156U, 155U, 154U, 153U, 152U, 151U, 150U,
    149U, 148U, 147U, 146U, 145U, 144U, 143U, 142U, 141U, 140U, 139U, 138U, 137U,
    136U, 135U, 134U, 133U, 132U, 131U, 130U, 129U, 128U, 127U, 126U, 125U, 124U,
    123U, 122U, 121U, 120U, 119U, 118U, 117U, 116U, 115U, 114U, 113U, 112U, 111U,
    110U, 109U, 108U, 107U, 106U, 105U, 104U, 103U, 102U, 101U, 100U, 99U, 98U,
    97U, 96U, 95U, 94U, 93U, 92U, 91U, 90U, 89U, 88U, 87U, 86U, 85U, 84U, 83U,
    82U, 81U, 80U, 79U, 78U, 77U, 76U, 75U, 74U, 73U, 72U, 71U, 70U, 69U, 68U,
    67U, 66U, 65U, 64U, 63U, 62U, 61U, 60U, 59U, 58U, 57U, 56U, 55U, 54U, 53U,
    52U, 51U, 50U, 49U, 48U, 47U, 46U, 45U, 44U, 43U, 42U, 41U, 40U, 39U, 38U,
    37U, 36U, 35U, 34U, 33U, 32U, 31U, 30U, 29U, 28U, 27U, 26U, 25U, 24U, 23U,
    22U, 21U, 20U, 19U, 18U, 17U, 16U, 15U, 14U, 13U, 12U, 11U, 10U, 9U, 8U, 7U,
    6U, 5U, 4U, 3U, 2U, 1U };

  int32_T c2_j;
  real_T c2_b_j;
  int32_T c2_i;
  real_T c2_b_i;
  for (c2_i38 = 0; c2_i38 < 242; c2_i38++) {
    c2_dv4[c2_i38] = -1.0 + (real_T)c2_i38;
  }

  c2_c_mod(chartInstance, c2_dv4, c2_dv5);
  for (c2_i39 = 0; c2_i39 < 242; c2_i39++) {
    c2_idxDir[c2_i39] = c2_uv3[sf_eml_array_bounds_check
      (sfGlobalDebugInstanceStruct, chartInstance->S, 1U, 0, 0, MAX_uint32_T,
       (int32_T)sf_integer_check(chartInstance->S, 1U, 0U, 0U, c2_dv5[c2_i39] +
        1.0), 1, 480) - 1];
  }

  for (c2_i40 = 0; c2_i40 < 242; c2_i40++) {
    c2_idxA[c2_i40] = (int32_T)c2_idxDir[c2_i40];
  }

  for (c2_i41 = 0; c2_i41 < 322; c2_i41++) {
    c2_dv6[c2_i41] = -1.0 + (real_T)c2_i41;
  }

  c2_d_mod(chartInstance, c2_dv6, c2_dv7);
  for (c2_i42 = 0; c2_i42 < 322; c2_i42++) {
    c2_b_idxDir[c2_i42] = c2_uv4[sf_eml_array_bounds_check
      (sfGlobalDebugInstanceStruct, chartInstance->S, 1U, 0, 0, MAX_uint32_T,
       (int32_T)sf_integer_check(chartInstance->S, 1U, 0U, 0U, c2_dv7[c2_i42] +
        1.0), 1, 640) - 1];
  }

  for (c2_i43 = 0; c2_i43 < 322; c2_i43++) {
    c2_idxA[c2_i43 + 322] = (int32_T)c2_b_idxDir[c2_i43];
  }

  for (c2_j = 0; c2_j < 322; c2_j++) {
    c2_b_j = 1.0 + (real_T)c2_j;
    for (c2_i = 0; c2_i < 242; c2_i++) {
      c2_b_i = 1.0 + (real_T)c2_i;
      c2_b[(sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
             chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)sf_integer_check
             (chartInstance->S, 1U, 0U, 0U, c2_b_i), 1, 242) + 242 *
            (sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
              chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)
              sf_integer_check(chartInstance->S, 1U, 0U, 0U, c2_b_j), 1, 322) -
             1)) - 1] = c2_b_varargin_1[(sf_eml_array_bounds_check
        (sfGlobalDebugInstanceStruct, chartInstance->S, 1U, 0, 0, MAX_uint32_T,
         (int32_T)sf_integer_check(chartInstance->S, 1U, 0U, 0U, (real_T)
        c2_idxA[sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct,
        chartInstance->S, 1U, 0, 0, MAX_uint32_T, (int32_T)sf_integer_check
        (chartInstance->S, 1U, 0U, 0U, c2_b_i), 1, 322) - 1]), 1, 240) + 240 *
        (sf_eml_array_bounds_check(sfGlobalDebugInstanceStruct, chartInstance->S,
        1U, 0, 0, MAX_uint32_T, (int32_T)sf_integer_check(chartInstance->S, 1U,
        0U, 0U, (real_T)c2_idxA[sf_eml_array_bounds_check
        (sfGlobalDebugInstanceStruct, chartInstance->S, 1U, 0, 0, MAX_uint32_T,
         (int32_T)sf_integer_check(chartInstance->S, 1U, 0U, 0U, c2_b_j), 1, 322)
        + 321]), 1, 320) - 1)) - 1];
    }
  }
}

static void c2_c_mod(SFc2_hdlcoder_medianimagefilterInstanceStruct
                     *chartInstance, real_T c2_x[242], real_T c2_r[242])
{
  int32_T c2_k;
  real_T c2_b_x;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_e_x;
  boolean_T c2_b;
  boolean_T c2_b4;
  real_T c2_f_x;
  boolean_T c2_b_b;
  boolean_T c2_b5;
  boolean_T c2_c_b;
  real_T c2_b_r;
  boolean_T c2_rEQ0;
  (void)chartInstance;
  for (c2_k = 0; c2_k < 242; c2_k++) {
    c2_b_x = c2_x[c2_k];
    c2_c_x = c2_b_x;
    c2_d_x = c2_c_x;
    c2_e_x = c2_d_x;
    c2_b = muDoubleScalarIsInf(c2_e_x);
    c2_b4 = !c2_b;
    c2_f_x = c2_d_x;
    c2_b_b = muDoubleScalarIsNaN(c2_f_x);
    c2_b5 = !c2_b_b;
    c2_c_b = (c2_b4 && c2_b5);
    if (c2_c_b) {
      if (c2_c_x == 0.0) {
        c2_b_r = 0.0;
      } else {
        c2_b_r = muDoubleScalarRem(c2_c_x, 480.0);
        c2_rEQ0 = (c2_b_r == 0.0);
        if (c2_rEQ0) {
          c2_b_r = 0.0;
        } else {
          if (c2_c_x < 0.0) {
            c2_b_r += 480.0;
          }
        }
      }
    } else {
      c2_b_r = rtNaN;
    }

    c2_r[c2_k] = c2_b_r;
  }
}

static void c2_d_mod(SFc2_hdlcoder_medianimagefilterInstanceStruct
                     *chartInstance, real_T c2_x[322], real_T c2_r[322])
{
  int32_T c2_k;
  real_T c2_b_x;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_e_x;
  boolean_T c2_b;
  boolean_T c2_b6;
  real_T c2_f_x;
  boolean_T c2_b_b;
  boolean_T c2_b7;
  boolean_T c2_c_b;
  real_T c2_b_r;
  boolean_T c2_rEQ0;
  (void)chartInstance;
  for (c2_k = 0; c2_k < 322; c2_k++) {
    c2_b_x = c2_x[c2_k];
    c2_c_x = c2_b_x;
    c2_d_x = c2_c_x;
    c2_e_x = c2_d_x;
    c2_b = muDoubleScalarIsInf(c2_e_x);
    c2_b6 = !c2_b;
    c2_f_x = c2_d_x;
    c2_b_b = muDoubleScalarIsNaN(c2_f_x);
    c2_b7 = !c2_b_b;
    c2_c_b = (c2_b6 && c2_b7);
    if (c2_c_b) {
      if (c2_c_x == 0.0) {
        c2_b_r = 0.0;
      } else {
        c2_b_r = muDoubleScalarRem(c2_c_x, 640.0);
        c2_rEQ0 = (c2_b_r == 0.0);
        if (c2_rEQ0) {
          c2_b_r = 0.0;
        } else {
          if (c2_c_x < 0.0) {
            c2_b_r += 640.0;
          }
        }
      }
    } else {
      c2_b_r = rtNaN;
    }

    c2_r[c2_k] = c2_b_r;
  }
}

static const mxArray *c2_emlrt_marshallOut
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance, const uint8_T
   c2_u[76800])
{
  const mxArray *c2_y = NULL;
  (void)chartInstance;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 3, 0U, 1U, 0U, 2, 240, 320),
                false);
  return c2_y;
}

static const mxArray *c2_b_emlrt_marshallOut
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance, const char_T
   c2_u[13])
{
  const mxArray *c2_y = NULL;
  (void)chartInstance;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 10, 0U, 1U, 0U, 2, 1, 13), false);
  return c2_y;
}

static const mxArray *c2_c_emlrt_marshallOut
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance, const real_T
   c2_u)
{
  const mxArray *c2_y = NULL;
  (void)chartInstance;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 0, 0U, 0U, 0U, 0), false);
  return c2_y;
}

static void c2_b_emlrt_marshallIn(SFc2_hdlcoder_medianimagefilterInstanceStruct *
  chartInstance, const mxArray *c2_imnoise, const char_T *c2_identifier, uint8_T
  c2_y[76800])
{
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = (const char *)c2_identifier;
  c2_thisId.fParent = NULL;
  c2_thisId.bParentIsCell = false;
  c2_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_imnoise), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_imnoise);
}

static void c2_c_emlrt_marshallIn(SFc2_hdlcoder_medianimagefilterInstanceStruct *
  chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  uint8_T c2_y[76800])
{
  uint8_T c2_uv5[76800];
  int32_T c2_i44;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_uv5, 1, 3, 0U, 1, 0U, 2, 240,
                320);
  for (c2_i44 = 0; c2_i44 < 76800; c2_i44++) {
    c2_y[c2_i44] = c2_uv5[c2_i44];
  }

  sf_mex_destroy(&c2_u);
}

static const mxArray *c2_d_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData;
  int32_T c2_u;
  const mxArray *c2_y = NULL;
  SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance;
  chartInstance = (SFc2_hdlcoder_medianimagefilterInstanceStruct *)
    chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_mxArrayOutData = NULL;
  c2_u = *(int32_T *)c2_inData;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static int32_T c2_d_emlrt_marshallIn
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance, const mxArray
   *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  int32_T c2_y;
  int32_T c2_i45;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_i45, 1, 6, 0U, 0, 0U, 0);
  c2_y = c2_i45;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_b_sfEvent;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  int32_T c2_y;
  SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance;
  chartInstance = (SFc2_hdlcoder_medianimagefilterInstanceStruct *)
    chartInstanceVoid;
  c2_b_sfEvent = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = (const char *)c2_identifier;
  c2_thisId.fParent = NULL;
  c2_thisId.bParentIsCell = false;
  c2_y = c2_d_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_b_sfEvent),
    &c2_thisId);
  sf_mex_destroy(&c2_b_sfEvent);
  *(int32_T *)c2_outData = c2_y;
  sf_mex_destroy(&c2_mxArrayInData);
}

static uint8_T c2_e_emlrt_marshallIn
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance, const mxArray
   *c2_b_is_active_c2_hdlcoder_medianimagefilter, const char_T *c2_identifier)
{
  uint8_T c2_y;
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = (const char *)c2_identifier;
  c2_thisId.fParent = NULL;
  c2_thisId.bParentIsCell = false;
  c2_y = c2_f_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c2_b_is_active_c2_hdlcoder_medianimagefilter), &c2_thisId);
  sf_mex_destroy(&c2_b_is_active_c2_hdlcoder_medianimagefilter);
  return c2_y;
}

static uint8_T c2_f_emlrt_marshallIn
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance, const mxArray
   *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  uint8_T c2_y;
  uint8_T c2_u0;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_u0, 1, 3, 0U, 0, 0U, 0);
  c2_y = c2_u0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void init_dsm_address_info(SFc2_hdlcoder_medianimagefilterInstanceStruct *
  chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address
  (SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance)
{
  chartInstance->c2_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c2_c_ImageIn = (uint8_T (*)[76800])ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c2_b_ImageOut = (uint8_T (*)[76800])
    ssGetOutputPortSignal_wrapper(chartInstance->S, 1);
  chartInstance->c2_density = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 1);
}

/* SFunction Glue Code */
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

void sf_c2_hdlcoder_medianimagefilter_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2576165624U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(2290953118U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3258958165U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1499148785U);
}

mxArray* sf_c2_hdlcoder_medianimagefilter_get_post_codegen_info(void);
mxArray *sf_c2_hdlcoder_medianimagefilter_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals", "postCodegenInfo" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1, 1, sizeof
    (autoinheritanceFields)/sizeof(autoinheritanceFields[0]),
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("53vdCuFMU6lKUNCg66Sf4D");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,2,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(240);
      pr[1] = (double)(320);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(3));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,0,mxREAL);
      double *pr = mxGetPr(mxSize);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,1,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(240);
      pr[1] = (double)(320);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(3));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  {
    mxArray* mxPostCodegenInfo =
      sf_c2_hdlcoder_medianimagefilter_get_post_codegen_info();
    mxSetField(mxAutoinheritanceInfo,0,"postCodegenInfo",mxPostCodegenInfo);
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c2_hdlcoder_medianimagefilter_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,2);
  mxSetCell(mxcell3p, 0, mxCreateString(
             "images.internal.coder.buildable.IppfilterBuildable"));
  mxSetCell(mxcell3p, 1, mxCreateString(
             "images.internal.coder.buildable.ImfilterBuildable"));
  return(mxcell3p);
}

mxArray *sf_c2_hdlcoder_medianimagefilter_jit_fallback_info(void)
{
  const char *infoFields[] = { "fallbackType", "fallbackReason",
    "hiddenFallbackType", "hiddenFallbackReason", "incompatibleSymbol" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 5, infoFields);
  mxArray *fallbackType = mxCreateString("late");
  mxArray *fallbackReason = mxCreateString("ir_function_calls");
  mxArray *hiddenFallbackType = mxCreateString("");
  mxArray *hiddenFallbackReason = mxCreateString("");
  mxArray *incompatibleSymbol = mxCreateString("ippfilter_uint8");
  mxSetField(mxInfo, 0, infoFields[0], fallbackType);
  mxSetField(mxInfo, 0, infoFields[1], fallbackReason);
  mxSetField(mxInfo, 0, infoFields[2], hiddenFallbackType);
  mxSetField(mxInfo, 0, infoFields[3], hiddenFallbackReason);
  mxSetField(mxInfo, 0, infoFields[4], incompatibleSymbol);
  return mxInfo;
}

mxArray *sf_c2_hdlcoder_medianimagefilter_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

mxArray* sf_c2_hdlcoder_medianimagefilter_get_post_codegen_info(void)
{
  const char* fieldNames[] = { "exportedFunctionsUsedByThisChart",
    "exportedFunctionsChecksum" };

  mwSize dims[2] = { 1, 1 };

  mxArray* mxPostCodegenInfo = mxCreateStructArray(2, dims, sizeof(fieldNames)/
    sizeof(fieldNames[0]), fieldNames);

  {
    mxArray* mxExportedFunctionsChecksum = mxCreateString("");
    mwSize exp_dims[2] = { 0, 1 };

    mxArray* mxExportedFunctionsUsedByThisChart = mxCreateCellArray(2, exp_dims);
    mxSetField(mxPostCodegenInfo, 0, "exportedFunctionsUsedByThisChart",
               mxExportedFunctionsUsedByThisChart);
    mxSetField(mxPostCodegenInfo, 0, "exportedFunctionsChecksum",
               mxExportedFunctionsChecksum);
  }

  return mxPostCodegenInfo;
}

static const mxArray *sf_get_sim_state_info_c2_hdlcoder_medianimagefilter(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x2'type','srcId','name','auxInfo'{{M[1],M[5],T\"ImageOut\",},{M[8],M[0],T\"is_active_c2_hdlcoder_medianimagefilter\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 2, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c2_hdlcoder_medianimagefilter_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance =
      (SFc2_hdlcoder_medianimagefilterInstanceStruct *)sf_get_chart_instance_ptr
      (S);
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _hdlcoder_medianimagefilterMachineNumber_,
           2,
           1,
           1,
           0,
           3,
           0,
           0,
           0,
           0,
           0,
           &chartInstance->chartNumber,
           &chartInstance->instanceNumber,
           (void *)S);

        /* Each instance must initialize its own list of scripts */
        init_script_number_translation(_hdlcoder_medianimagefilterMachineNumber_,
          chartInstance->chartNumber,chartInstance->instanceNumber);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          sf_debug_set_chart_disable_implicit_casting
            (sfGlobalDebugInstanceStruct,
             _hdlcoder_medianimagefilterMachineNumber_,
             chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds(sfGlobalDebugInstanceStruct,
            _hdlcoder_medianimagefilterMachineNumber_,
            chartInstance->chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,1,1,0,"ImageIn");
          _SFD_SET_DATA_PROPS(1,1,1,0,"density");
          _SFD_SET_DATA_PROPS(2,2,0,1,"ImageOut");
          _SFD_STATE_INFO(0,0,2);
          _SFD_CH_SUBSTATE_COUNT(0);
          _SFD_CH_SUBSTATE_DECOMP(0);
        }

        _SFD_CV_INIT_CHART(0,0,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);

        /* Initialization of MATLAB Function Model Coverage */
        _SFD_CV_INIT_EML(0,1,1,0,0,0,0,0,0,0,0,0);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",1,-1,271);

        {
          unsigned int dimVector[2];
          dimVector[0]= 240U;
          dimVector[1]= 320U;
          _SFD_SET_DATA_COMPILED_PROPS(0,SF_UINT8,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_b_sf_marshallOut,(MexInFcnForType)NULL);
        }

        _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c2_c_sf_marshallOut,(MexInFcnForType)NULL);

        {
          unsigned int dimVector[2];
          dimVector[0]= 240U;
          dimVector[1]= 320U;
          _SFD_SET_DATA_COMPILED_PROPS(2,SF_UINT8,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_b_sf_marshallOut,(MexInFcnForType)
            c2_sf_marshallIn);
        }
      }
    } else {
      sf_debug_reset_current_state_configuration(sfGlobalDebugInstanceStruct,
        _hdlcoder_medianimagefilterMachineNumber_,chartInstance->chartNumber,
        chartInstance->instanceNumber);
    }
  }
}

static void chart_debug_initialize_data_addresses(SimStruct *S)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance =
      (SFc2_hdlcoder_medianimagefilterInstanceStruct *)sf_get_chart_instance_ptr
      (S);
    if (ssIsFirstInitCond(S)) {
      /* do this only if simulation is starting and after we know the addresses of all data */
      {
        _SFD_SET_DATA_VALUE_PTR(0U, (void *)chartInstance->c2_c_ImageIn);
        _SFD_SET_DATA_VALUE_PTR(2U, (void *)chartInstance->c2_b_ImageOut);
        _SFD_SET_DATA_VALUE_PTR(1U, (void *)chartInstance->c2_density);
      }
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "sE9GONhqB5mLpVe0DtuB6NF";
}

static void sf_opaque_initialize_c2_hdlcoder_medianimagefilter(void
  *chartInstanceVar)
{
  chart_debug_initialization(((SFc2_hdlcoder_medianimagefilterInstanceStruct*)
    chartInstanceVar)->S,0);
  initialize_params_c2_hdlcoder_medianimagefilter
    ((SFc2_hdlcoder_medianimagefilterInstanceStruct*) chartInstanceVar);
  initialize_c2_hdlcoder_medianimagefilter
    ((SFc2_hdlcoder_medianimagefilterInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c2_hdlcoder_medianimagefilter(void
  *chartInstanceVar)
{
  enable_c2_hdlcoder_medianimagefilter
    ((SFc2_hdlcoder_medianimagefilterInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c2_hdlcoder_medianimagefilter(void
  *chartInstanceVar)
{
  disable_c2_hdlcoder_medianimagefilter
    ((SFc2_hdlcoder_medianimagefilterInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c2_hdlcoder_medianimagefilter(void
  *chartInstanceVar)
{
  sf_gateway_c2_hdlcoder_medianimagefilter
    ((SFc2_hdlcoder_medianimagefilterInstanceStruct*) chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c2_hdlcoder_medianimagefilter
  (SimStruct* S)
{
  return get_sim_state_c2_hdlcoder_medianimagefilter
    ((SFc2_hdlcoder_medianimagefilterInstanceStruct *)sf_get_chart_instance_ptr
     (S));                             /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c2_hdlcoder_medianimagefilter(SimStruct* S,
  const mxArray *st)
{
  set_sim_state_c2_hdlcoder_medianimagefilter
    ((SFc2_hdlcoder_medianimagefilterInstanceStruct*)sf_get_chart_instance_ptr(S),
     st);
}

static void sf_opaque_terminate_c2_hdlcoder_medianimagefilter(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc2_hdlcoder_medianimagefilterInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_hdlcoder_medianimagefilter_optimization_info();
    }

    finalize_c2_hdlcoder_medianimagefilter
      ((SFc2_hdlcoder_medianimagefilterInstanceStruct*) chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc2_hdlcoder_medianimagefilter
    ((SFc2_hdlcoder_medianimagefilterInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c2_hdlcoder_medianimagefilter(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c2_hdlcoder_medianimagefilter
      ((SFc2_hdlcoder_medianimagefilterInstanceStruct*)sf_get_chart_instance_ptr
       (S));
  }
}

static void mdlSetWorkWidths_c2_hdlcoder_medianimagefilter(SimStruct *S)
{
  /* Set overwritable ports for inplace optimization */
  ssSetInputPortDirectFeedThrough(S, 0, 1);
  ssSetInputPortDirectFeedThrough(S, 1, 1);
  ssSetStatesModifiedOnlyInUpdate(S, 1);
  ssSetBlockIsPurelyCombinatorial_wrapper(S, 1);
  ssMdlUpdateIsEmpty(S, 1);
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct = load_hdlcoder_medianimagefilter_optimization_info
      (sim_mode_is_rtw_gen(S), sim_mode_is_modelref_sim(S), sim_mode_is_external
       (S));
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(sf_get_instance_specialization(),infoStruct,2);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,1);
    ssSetSupportedForRowMajorCodeGen(S, 1);
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop
      (sf_get_instance_specialization(),infoStruct,2,
       "gatewayCannotBeInlinedMultipleTimes"));
    sf_set_chart_accesses_machine_info(S, sf_get_instance_specialization(),
      infoStruct, 2);
    sf_update_buildInfo(S, sf_get_instance_specialization(),infoStruct,2);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,2,2);
      sf_mark_chart_reusable_outputs(S,sf_get_instance_specialization(),
        infoStruct,2,1);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=1; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 2; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,2);
    sf_register_codegen_names_for_scoped_functions_defined_by_chart(S);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(2063336177U));
  ssSetChecksum1(S,(2177465675U));
  ssSetChecksum2(S,(1265983819U));
  ssSetChecksum3(S,(1762160791U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSetStateSemanticsClassicAndSynchronous(S, true);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c2_hdlcoder_medianimagefilter(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c2_hdlcoder_medianimagefilter(SimStruct *S)
{
  SFc2_hdlcoder_medianimagefilterInstanceStruct *chartInstance;
  chartInstance = (SFc2_hdlcoder_medianimagefilterInstanceStruct *)utMalloc
    (sizeof(SFc2_hdlcoder_medianimagefilterInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc2_hdlcoder_medianimagefilterInstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c2_hdlcoder_medianimagefilter;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c2_hdlcoder_medianimagefilter;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c2_hdlcoder_medianimagefilter;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c2_hdlcoder_medianimagefilter;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c2_hdlcoder_medianimagefilter;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c2_hdlcoder_medianimagefilter;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c2_hdlcoder_medianimagefilter;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c2_hdlcoder_medianimagefilter;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c2_hdlcoder_medianimagefilter;
  chartInstance->chartInfo.mdlStart = mdlStart_c2_hdlcoder_medianimagefilter;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c2_hdlcoder_medianimagefilter;
  chartInstance->chartInfo.callGetHoverDataForMsg = NULL;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->chartInfo.callAtomicSubchartUserFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartAutoFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartEventFcn = NULL;
  chartInstance->chartInfo.debugInstance = sfGlobalDebugInstanceStruct;
  chartInstance->S = S;
  sf_init_ChartRunTimeInfo(S, &(chartInstance->chartInfo), false, 0);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  chart_debug_initialization(S,1);
  mdl_start_c2_hdlcoder_medianimagefilter(chartInstance);
}

void c2_hdlcoder_medianimagefilter_method_dispatcher(SimStruct *S, int_T method,
  void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c2_hdlcoder_medianimagefilter(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c2_hdlcoder_medianimagefilter(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c2_hdlcoder_medianimagefilter(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c2_hdlcoder_medianimagefilter_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
