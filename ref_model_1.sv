class ref_model_1;
  
  task Bit_Manipulation_Unit (
    input logic  rst_l,
    input logic scan_mode, // Scan control
    input rtl_alu_pkt_t  ap, 
    input logic signed  [31:0] a_in,
    input logic [31:0] b_in,
    input logic               valid_in,       // Valid
    input logic              csr_ren_in,     // CSR select
    input logic         [31:0] csr_rddata_in,  // CSR data
  
    output logic [31:0] result_ff,
    output logic error
  );

    // Reset handling
    if (!rst_l)begin 
      result_ff = 0;
      error = 0;
    end else if(valid_in && !scan_mode) begin
      	//initialize Error flag 
      	error=0; // Default result_rf to zero
      	result_ff=0; // Default error_rf to zero
      
      	////Control Status Register Operations
      	//1.	CSR Bypass Input Data
      	case(1'b1)
        	(ap == 0): begin 
            	  if(csr_ren_in)begin 
              	    result_ff= csr_rddata_in;
            	  end else begin 
              	    result_ff=32'b0;
              	    error=1;
            	  end
        	end
                
        	//2.	CSR Write Data:
        	(ap.csr_write == 1):begin 
          	    if( !(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h ||ap.min || ap.max || ap.pack || ap.packu || ap.packh ||ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb ||ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add ||ap.sh2add || ap.sh3add || ap.zba ||ap.land || ap.lor  || ap.lxor ||ap.sll || ap.srl || ap.sra || ap.beq || ap.bne ||ap.blt || ap.bge || ap.add || ap.sub || ap.slt ||ap.unsign || ap.jal || ap.predict_t || ap.predict_nt)) begin 
            	      result_ff = ap.csr_imm ? b_in : a_in; 
         	    end else begin 
              	    result_ff=32'b0;
                    error=1;
            	end 
        	end
        
      		  ////	Logic operations
       		 //3. Logical AND operation controlled by ap.land
       		(ap.land == 1): begin
                // Condition: If all other ap fields are 0 and csr_ren_in = 0
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h ||ap.min || ap.max || ap.pack || ap.packu || ap.packh ||ap.rol || ap.ror || ap.grev || ap.gorc ||ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add ||ap.sh2add || ap.sh3add || ap.zba || ap.lor || ap.lxor ||ap.sll || ap.srl || ap.sra || ap.beq || ap.bne ||ap.blt || ap.bge || ap.add || ap.sub || ap.slt ||ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write ||ap.csr_imm) && csr_ren_in == 0) begin
                 // Sub-condition: If ap.zbb = 0, then result = a_in & b_in
                    if (ap.zbb == 0) begin
                        result_ff = a_in & b_in;
                        // Sub-condition: If ap.zbb = 1, then result = a_in & ~b_in
                    end else begin   //if ap.zbb isnt zero
                        result_ff = a_in & ~b_in;
                    end
                end else begin
                    // Else: Set error = 1 and result = 0
                    result_ff = 32'b0;
                    error = 1'b1;
                end
          end
        
        
        //4. Logical OR operation controlled by ap.lor
          (ap.lor == 1): begin
                // Condition: If all other ap fields are 0 and csr_ren_in = 0
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h ||ap.min || ap.max || ap.pack || ap.packu || ap.packh ||ap.rol || ap.ror || ap.grev || ap.gorc||ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add ||ap.sh2add || ap.sh3add || ap.zba || ap.land || ap.lxor ||ap.sll || ap.srl || ap.sra || ap.beq || ap.bne ||ap.blt || ap.bge || ap.add || ap.sub || ap.slt ||ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write ||ap.csr_imm) && csr_ren_in == 0) begin
                    // Sub-condition: If ap.zbb = 0, then result = a_in & b_in
                    if (ap.zbb == 0) begin
                        result_ff = a_in | b_in;
                        // Sub-condition: If ap.zbb = 1, then result = a_in & ~b_in
                    end else begin   //if other ap fields ≠ 0 or csr_ren_in ≠ 0
                        result_ff = a_in | ~b_in;
                    end
                end else begin
                    // Else: Set error = 1 and result = 0
                    result_ff = 32'b0;
                    error = 1'b1;
                end
            end
        
        
        //5. Logical XOR operation controlled by ap.Ixor
          (ap.lxor == 1): begin
                // Condition: If all other ap fields are 0 and csr_ren_in = 0
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h ||ap.min || ap.max || ap.pack || ap.packu || ap.packh ||ap.rol || ap.ror || ap.grev || ap.gorc ||ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add ||ap.sh2add || ap.sh3add || ap.zba || ap.land || ap.lor ||ap.sll || ap.srl || ap.sra || ap.beq || ap.bne ||ap.blt || ap.bge || ap.add || ap.sub || ap.slt ||ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write ||ap.csr_imm) && csr_ren_in == 0) begin
                    // Sub-condition: If ap.zbb = 0, then result = a_in & b_in
                    if (ap.zbb == 0) begin
                        result_ff = a_in ^ b_in;
                        // Sub-condition: If ap.zbb = 1, then result = a_in & ~b_in
                    end else begin   //if other ap fields ≠ 0 or csr_ren_in ≠ 0
                        result_ff = a_in ^ ~b_in;
                    end
                end else begin
                    // Else: Set error = 1 and result = 0
                    result_ff = 32'b0;
                    error = 1'b1;
                end
          end
        
        ////	Shifting And Masking Operations.
        //6. Left Shift Operation (sll)
          (ap.sll == 1): begin
                              //   check if other ap fields is zero
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc ||ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add || ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                    result_ff = a_in << b_in[4:0];          // Shift the value in a_in left by the value in the lower 5 bits of b_in
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end
        
        //7. Right Logical Shift Operation (srl)
          (ap.srl == 1): begin
                    //check if other ap fields is zero
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc ||ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add || ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                    result_ff = a_in >> b_in[4:0];// Logical shift the value in a_in right by the value in the lower 5 bits of b_in
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end
        
        // 8. Right Arithmetic Shift Operation (sra)
          (ap.sra == 1): begin
                    //check if other ap fields is zero
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add || ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                    result_ff = a_in >>> b_in[4:0];
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end
        
        // 9. Rotate Left Operation (rol)
          (ap.rol == 1): begin
                    //           check if other ap fields is zero
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add || ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                    result_ff = (a_in << b_in[4:0]) | (a_in >> (32 - b_in[4:0])); //left-shifts a_in by the number of bits specified in b_in[4:0], then right-shifts a_in by the remaining bits (32 minus b_in[4:0]). Finally, it combines both shifted results using a bitwise OR operation to get a Rotate a_in left by the lower 5 bits in b_in,.
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end
        
        
        // 10. Rotate Right Operation (ror)
          (ap.ror == 1): begin
                    //check if other ap fields is zero
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add || ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                    result_ff = (a_in >> b_in[4:0]) | (a_in << (32 - b_in[4:0]));//right-shifts a_in by the number of bits specified in b_in[4:0], then left-shifts a_in by the remaining bits (32 minus b_in[4:0]). Finally, it combines both shifted results using a bitwise OR operation to get a Rotate a_in left by the lower 5 bits in b_in,.
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end
        
        // 11. Bit Extraction (bext)
          (ap.bext == 1): begin
                    //check if other ap fields is zero
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.sh1add || ap.sh2add || ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra|| ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin        
                    result_ff = (a_in >> b_in[4:0]) & 1;// Shift the value of a_in by the number of positions specified by the lower 5 bits of b_in
                    // Then perform a bitwise AND with 1 to isolate the least significant bit
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end
       
        // 12. Bit Inverse (binv)
          (ap.binv == 1): begin
                    //check if other ap fields is zero
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.bext || ap.sh1add || ap.sh2add || ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                    result_ff = (a_in & ~(1 << b_in[4:0])) | (~a_in & (1 << b_in[4:0]));// Invert the bit at the specified index in a_in then We shift the value 1 by the index specified in the lower 5 bits of b_in
                    // finally perform bitwise AND with a_in and its complement to toggle the specified bit
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end
        
        //13.  Shift left by 1 and add
          (ap.sh1add == 1): begin
                //check if other ap fields is zero
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh2add || ap.sh3add || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                  if(ap.zba==1) begin
                    result_ff = (a_in << 1) + b_in;
                  end else begin
                    result_ff = 32'b0;
                    error = 1;
                  end
                end else begin 
                    result_ff = 32'b0;
                    error = 1;
                end
          end
        
        
        //14.  Shift left by 2 and add
          (ap.sh2add == 1): begin
                   //check if other ap fields is zero
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh3add  || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                  if (ap.zba==1) begin
                    result_ff = (a_in << 2) + b_in;
                  end else begin
                    result_ff = 32'b0;
                    error = 1;
                  end
                end else begin 
                  result_ff = 32'b0;
                    error = 1;
                end
          end
        
        //14.  Shift left by 2 and add
          (ap.sh3add == 1): begin
                    //check if other ap fields is zero
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                  if (ap.zba==1) begin 
                    result_ff = (a_in << 3) + b_in;
                  end else begin
                    result_ff = 32'b0;
                    error = 1;
                  end
                end else begin
                  result_ff = 32'b0;
                  error = 1;
                end
          end
        
       
        ////	Arithmetic Operations
       // 16. Subtract Operation (sub)
          (ap.sub == 1 ): begin
                  //check if other ap fields is zero
                if(!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add ||ap.sh3add || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                  if (ap.zba==0) begin
                    result_ff = a_in - b_in;
                  end else begin
                    result_ff = 32'b0;
                    error = 1;
                  end
                end else begin 
                  result_ff = 32'b0;
                  error = 1;
                end
          end
        
         // 17. Addition Operation (add)
          (ap.add == 1): begin
                  //  check if other ap fields is zero
                if(!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add || ap.sh3add || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.beq || ap.bne || ap.blt || ap.bge || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin 
                    result_ff = a_in + b_in;
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end 
          end
        
        
        ////   Bit Manipulation 
        //18. Set on less than
          (ap.slt == 1): begin
                //check if other ap fields is zero (include the ap.signed)
                if(!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add || ap.sh3add|| ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra|| ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin 
                  result_ff = ($signed(a_in) < $signed(~b_in+1))? 1:0;//result=1 when a_in is less then b_in otherwise result0
                  $display("Performing SLT operation between signed(a_in): %0d and signed(b_in): %0d", a_in,$signed(b_in));
                end else begin
                    result_ff = 32'b0; // Default value if the condition does not match
                    error = 1;         // Set error flag for incorrect condition
                end
          end
        
        
        //19. Count leading zero bits 
	      (ap.clz == 1): begin
                if(!( ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh ||   ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add||ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra|| ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub ||ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                  integer i;
                  integer count_0;
                  count_0 = 0; // Initialize count to zero
                    // Loop from the most significant bit to the least significant bit
                      for(i=31; i>=0; i--) begin
                          if (a_in[i]==1'b0) begin 
                              count_0++; // Increment count for each leading zero
                          end else begin 
                              break;// Stop when the first '1' is found.
                          end
                      end 
            
                      if(a_in==32'b0) begin 
                          result_ff=32'b0; // If input is all zeros, result is 32
                      end else if (a_in[31]==1'b1) begin 
                          result_ff=32'b0; // If the MSB is 1, result is 0
                      end else begin 
                          result_ff=count_0; // Set result to the count of leading zeros
                      end
                end else begin
                    result_ff = 32'b0; // Default value if the condition does not match
                    error = 1;         // Set error flag for incorrect condition
                end
          end
          
          //20. Count trailing zero bits (ap.ctz)
          (ap.ctz == 1): begin
                if (!(ap.clz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                    integer i;
                    integer count_ctz_0;
                    count_ctz_0 = 0; // Initialize count to zero
                    for (i = 0; i <= 31; i++) begin
                        if (a_in[i] == 1'b0) begin
                            count_ctz_0++; // Increment count for each trailing zero
                        end else begin
                            break; // Stop when the first '1' is found.
                        end
                    end
                    if (a_in == 32'b0) begin
                        result_ff = 0; // If input is all zeros, result is 0
                    end else if (a_in[0] == 1'b1) begin
                        result_ff = 0; // If the LSB is 1, result is 0
                    end else begin
                        result_ff = count_ctz_0; // Set result to the count of trailing zeros
                    end
              end else begin
                  result_ff = 32'b0;
                  error = 1;
              end
          end
          
          //21. Count Set Bits/ Population Count (ap.cpop)
          (ap.cpop == 1): begin
                if (!(ap.clz || ap.ctz || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add ||ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                    integer i;//index to run over the a_in
                    integer pop_count;
                    pop_count = 0; // Initialize count to zero
                  for (i = 0; i <= 31; i++) begin
                    if (a_in[i] == 1'b1) begin
                        pop_count++; // Increment count for each set bit
                    end
                  end
                result_ff = pop_count; // Set result to the count of set bits
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end
          
          //22. Count Set Bits/ Population Count (ap.cpop)
          (ap.cpop == 1): begin
                if (!(ap.clz || ap.ctz || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                    integer i;//index to run over the a_in
                    integer pop_count;
                    pop_count = 0; // Initialize count to zero
                  for (i = 0; i <= 31; i++) begin
                    if (a_in[i] == 1'b1) begin
                        pop_count++; // Increment count for each set bit
                    end
                  end
                result_ff = pop_count; // Set result to the count of set bits
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end
          
          //23. Sign Extend Byte (ap.siext_b)
          (ap.siext_b == 1): begin
                if(!(ap.clz || ap.ctz || ap.cpop || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add ||ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
//                   result_ff[31:8]={24{a_in[7]}};
//                   result_ff[7:0]=a_in[7:0];
                    result_ff = {{24{a_in[7]}}, a_in[7:0]}; // Sign extend a_in[7] to bits [31:8]
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end

        //24. Sign Extend Halfword (ap.siext_h)
          (ap.siext_h == 1): begin
                if(!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.min || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add ||ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                    result_ff = {{16{a_in[15]}}, a_in[15:0]}; // Sign extend a_in[15] to bits [31:16]
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end

          
          //25. Maximum (ap.max)
          (ap.max == 1): begin
                if(!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add ||ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                  logic signed [31:0] signed_a_in = a_in;
                  logic signed [31:0] signed_b_in = b_in;
                  result_ff = (signed_a_in > $signed(~b_in+1)) ? a_in : b_in;
//                   result_ff = ($signed(a_in) > $signed(b_n)) ? a_in : b_in; // Set result to the larger of signed a_in and b_in
                  $display("Performing SLT operation between signed(a_in): %0d and signed(b_in): %0d", a_in,$signed(b_in));
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end

          //26. Minimum (ap.min)
          (ap.min == 1): begin
                if(!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.max || ap.pack || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                  logic signed [31:0] signed_a_in = a_in;
                  logic signed [31:0] signed_b_in = b_in;
                  result_ff = (signed_a_in < $signed(~b_in+1)) ? a_in : b_in;
//                   result_ff = ($signed(a_in) < $signed(b_in)) ? a_in : b_in; // Set result to the smaller of signed a_in and b_in
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end
          
          
          //27. Pack (ap.pack)
          (ap.pack == 1): begin
                if(!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.packu || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add ||ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                    result_ff = {b_in[15:0], a_in[15:0]}; // Concatenate LSB halves of a_in and b_in
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end
          
          
          //27. Packu (ap.packu)
          (ap.packu == 1): begin
                if(!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packh || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add ||ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                  result_ff = {b_in[31:16], a_in[31:16]}; // Concatenate MSB halves of a_in and b_in
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end
          
          
           //28. Packh (ap.packh)
          (ap.packh == 1): begin
                if(!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.rol || ap.ror || ap.grev || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add ||ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                    result_ff = {b_in[7:0], a_in[7:0]}; // Concatenate LSB bytes of a_in and b_in
                end else begin
                    result_ff = 32'b0;
                    error = 1;
                end
          end
          
          //30. Byte-reverse register (ap.grev)
          (ap.grev == 1): begin
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu ||ap.packh || ap.rol || ap.ror || ap.gorc || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add ||ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                  if (b_in == 24) begin 
                    result_ff = {a_in[7:0], a_in[15:8], a_in[23:16], a_in[31:24]}; // Reverse the order of the bytes in a_in
                  end else begin
                    result_ff = 32'b0; // Set result to zero if b_in is not 24
                  end
                end else begin
                   result_ff = 32'b0;
                   error = 1;
                end
          end
    

          //31. Bitwise OR-combine, byte granule (ap.gorc)
          (ap.gorc == 1): begin
                if (!(ap.clz || ap.ctz || ap.cpop || ap.siext_b || ap.siext_h || ap.min || ap.max || ap.pack || ap.packu || ap.rol || ap.packh|| ap.ror || ap.grev  || ap.zbb || ap.bset || ap.bclr || ap.binv || ap.bext || ap.sh1add || ap.sh2add ||ap.sh3add || ap.zba || ap.land || ap.lor || ap.lxor || ap.sll || ap.srl || ap.sra || ap.beq || ap.bne || ap.blt || ap.bge || ap.add || ap.sub || ap.slt || ap.unsign || ap.jal || ap.predict_t || ap.predict_nt || ap.csr_write || ap.csr_imm)) begin
                  if (b_in[4:0] == 5'b00111) begin 
                    result_ff[7:0]   = (|a_in[7:0])   ? 8'hFF : 8'h00;
                    result_ff[15:8]  = (|a_in[15:8])  ? 8'hFF : 8'h00;
                    result_ff[23:16] = (|a_in[23:16]) ? 8'hFF : 8'h00;
                    result_ff[31:24] = (|a_in[31:24]) ? 8'hFF : 8'h00; // Set each byte to all 1s if any bit in the byte is set, otherwise set to all 0s
                  end else begin
                    result_ff = 32'b0; // Set result to zero if b_in is not 24
                  end
                end else begin
                  result_ff = 32'b0;
                  error = 1;
                end
          end
          
          
          
          
          default: begin //If none of the cases are executed, set error to 1
                result_ff=32'b0;
                error=1;
          end
        endcase
      
      
    end else begin //if [reset isnt active(rst_l is 1) or( valid_in isnt 1 and scan_mode isnt 0)]
      result_ff=32'b0;
      error=1;
    end   
  endtask
endclass
    
    