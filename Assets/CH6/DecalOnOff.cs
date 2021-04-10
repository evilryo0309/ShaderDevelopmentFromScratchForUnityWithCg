using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class DecalOnOff : MonoBehaviour
{
    bool showDecal = false;
    Material mat;

    private void Start()
    {
        mat = GetComponent<Renderer>().sharedMaterial;
    }

    private void OnMouseDown()
    {
        showDecal = !showDecal;
        if (showDecal)
            mat.SetFloat("_ShowDecal", 1);
        else
            mat.SetFloat("_ShowDecal", 0);
    }
}
