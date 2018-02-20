#version 300 es

#define MAX_INSTANCES 200

/*----------  Shader Uniforms  ----------*/
uniform mat4 u_Model;
uniform mat4 u_ModelInvTr;
uniform mat4 u_ViewProj;
uniform int u_Time;
uniform vec4 u_Eye;

uniform mat4 u_InstanceModel[MAX_INSTANCES];

/*----------  Shader UI Controls  ----------*/
uniform vec3 u_ControlsWaterBedrock1Color;
uniform vec3 u_ControlsWaterBedrock2Color;
uniform vec3 u_ControlsSandColor;
uniform float u_ControlsWaterLevel;
uniform float u_ControlsShoreLevel;
uniform float u_ControlsElevation;
uniform float u_ControlsNoiseScale;

/*----------  Shader Inputs  ----------*/
in vec4 vs_Pos;
in vec4 vs_Nor;
in vec4 vs_Col;

/*----------  Shader Outputs  ----------*/
out vec4 fs_Nor;
out vec4 fs_LightVec;
out vec4 fs_Col;
out vec4 fs_Pos;
out vec4 fs_SphereNor;
out float fs_Spec;
out float fs_Valid;
out float fs_useMatcap;



void main() {
  vec4 vertexColor;
  vec4 lightPos = vec4(-10, -10, -10, 1);
  vec4 vertexPosition = vs_Pos;
  vec4 vertexNormal = vs_Nor;

  fs_Col = vec4(0,0.7,0.3,1);

  mat3 invTranspose = mat3(u_ModelInvTr);
  fs_Nor = vec4(invTranspose * vec3(vertexNormal), 0);

  vec4 modelposition = u_Model * vertexPosition;

  fs_Pos = modelposition;

  fs_LightVec = lightPos - modelposition;

  gl_Position = u_ViewProj * modelposition;
}
