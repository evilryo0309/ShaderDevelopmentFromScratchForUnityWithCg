using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeshData : MonoBehaviour
{
	void Start ()
    {
        Mesh mesh = GetComponent<MeshFilter>().mesh;
        Vector3[] vertices = mesh.vertices;
        foreach (Vector3 vertex in vertices)
        {
            Debug.Log(vertex);
        }
	}
}
