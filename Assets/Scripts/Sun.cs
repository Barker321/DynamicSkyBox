using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Sun : MonoBehaviour
{
    public Material skyBox;
    // Start is called before the first frame update
    void Start()
    {
        Matrix4x4 LtoW = this.transform.localToWorldMatrix;
    }

    // Update is called once per frame
    void Update()
    {
        Matrix4x4 LtoW = this.transform.localToWorldMatrix;
        skyBox.SetVector("_SunDirection", this.transform.forward.normalized);
        Debug.Log(this.transform.forward);
    }
}
